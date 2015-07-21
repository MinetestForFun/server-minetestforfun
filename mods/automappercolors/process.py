#!/usr/bin/env python2
# Automappercolors by gravgun
# WTFPL
# Note: running this in Pypy has been tested to be ~3x faster

from __future__ import print_function
import sys, os, re
from PIL import Image

predefined = {
    #"^default:river_water_([a-z]+)": {'r': 39, 'g': 66, 'b': 106, 'a': 128, 't': 224},
    #"^default:lava_([a-z]+)": {'r': 255, 'g': 100, 'b': 0},
    "^default:([a-z_]*)glass": {'a': 64, 't': 16},
    "^default:torch": {'r': 255, 'g': 255},
    "^default:ice": {'r': 74, 'g': 105, 'b': 159, 'a': 159},
    "^default:water_([a-z]+)": {'r': 38, 'g': 68, 'b': 157},
    "^default:dirt_with_grass": {'r': 72, 'g': 154, 'b': 21}
}

predef_compiled = {}
for k in predefined:
    predef_compiled[re.compile(k)] = predefined[k]

if len(sys.argv) <= 2:
    print("Usage: %s <world path> <minetest data root path>" % sys.argv[0])
else:
    pngpaths = {}
    for root, dirs, files in os.walk(sys.argv[2]):
        for dir in dirs:
            if dir[0] == ".": # No dotdirs
                dirs.remove(dir)
        for file in files:
            pngpaths[file] = os.path.join(root, file)
    out = open(os.path.join(sys.argv[1], "colors.txt"), 'w')
    f = open(os.path.join(sys.argv[1], "amc_nodes.txt"), 'r')
    for line in f:
        ldata = line.split(' ')
        if len(ldata) == 2:
            nodename = ldata[0]
            tex = ldata[1][:-1] # Strip newline char
            try:
                a_override = None
                t_override = None
                compute = True
                ccumul = [0, 0, 0, 0]
                for k in predef_compiled:
                    if k.match(nodename) is not None:
                        v = predef_compiled[k]
                        if 'r' in v:
                            ccumul[0] = v['r']
                            compute = False
                        if 'g' in v:
                            ccumul[1] = v['g']
                            compute = False
                        if 'b' in v:
                            ccumul[2] = v['b']
                            compute = False
                        if 'a' in v:
                            a_override = v['a']
                        if 't' in v:
                            t_override = v['t']

                if compute:
                    inp = Image.open(pngpaths[tex])
                    # Flaky PILlow bug causing unclosed fp loss during convert
                    # resulting in a Too many files open IOError
                    inpfp = inp.fp
                    inp2 = inp.convert('RGBA')
                    ind = inp2.load()
                    inpfp.close()
                    pixcount = 0
                    for x in range(inp.size[0]):
                        for y in range(inp.size[1]):
                            pxl = ind[x, y]
                            ccumul[0] += (pxl[0]*pxl[3])/255
                            ccumul[1] += (pxl[1]*pxl[3])/255
                            ccumul[2] += (pxl[2]*pxl[3])/255
                            ccumul[3] += pxl[3]
                    if ccumul[3] > 0:
                        for i in range(3):
                            ccumul[i] /= ccumul[3]/255
                    if a_override is None:
                        a = ccumul[3]/(inp.size[0]*inp.size[1])
                    else:
                        a = a_override
                    if t_override is None:
                        t = 255-a
                    else:
                        t = t_override

                if t != 0:
                    out.write("%s %d %d %d %d %d\n" % (nodename, ccumul[0], ccumul[1], ccumul[2], a, t))
                elif a != 255:
                    out.write("%s %d %d %d %d\n" % (nodename, ccumul[0], ccumul[1], ccumul[2], a))
                else:
                    out.write("%s %d %d %d\n" % (nodename, ccumul[0], ccumul[1], ccumul[2]))
            except KeyError:
                print("Skip texture %s for %s" % (tex, nodename))
    out.close()
    f.close()