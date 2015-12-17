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
    "^default:torch": {'r': 255, 'g': 255, 'b': 0, 'a': 255},
    "^default:ice": {'r': 74, 'g': 105, 'b': 159, 'a': 159},
    "^default:water_([a-z]+)": {'r': 43, 'g': 97, 'b': 183, 'a': 128},
    "^default:dirt_with_grass": {'r': 107, 'g': 134, 'b': 51, 'a': 255},
    "^flowers:cotton_plant": {'r': 199, 'g': 218, 'b': 158},
    "^flowers:seaweed": {'r': 48, 'g': 114, 'b': 107},
    "^flowers:waterlily": {'r': 119, 'g': 166, 'b': 100},
    "^flowers:waterlily_225": {'r': 119, 'g': 166, 'b': 100},
    "^flowers:waterlily_45": {'r': 119, 'g': 166, 'b': 100},
    "^flowers:waterlily_675": {'r': 119, 'g': 166, 'b': 100},
    "^flowers:dandelion_white": {'r': 161, 'g': 174, 'b': 149},
    "^flowers:dandelion_yellow": {'r': 144, 'g': 138, 'b': 0},
    "^flowers:geranium": {'r': 75, 'g': 101, 'b': 84},
    "^flowers:rose": {'r': 153, 'g': 9, 'b': 0},
    "^flowers:tulip": {'r': 175, 'g': 114, 'b': 0},
    "^flowers:viola": {'r': 84, 'g': 90, 'b': 64},
    "^glass_arena:wall": {'r': 255, 'g': 0, 'b': 0}
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
                r_override = None
                g_override = None
                b_override = None
                a_override = None
                t_override = None
                compute = True
                for k in predef_compiled:
                    if k.match(nodename) is not None:
                        v = predef_compiled[k]
                        if 'r' in v:
                            r_override = ccumul[0] = v['r']
                        if 'g' in v:
                            g_override = ccumul[1] = v['g']
                        if 'b' in v:
                            b_override = ccumul[2] = v['b']
                        if 'a' in v:
                            a_override = a = v['a']
                        if 't' in v:
                            t_override = t = v['t']
                        compute = not('r' in v and 'g' in v and 'b' in v and 'a' in v)

                if compute:
                    inp = Image.open(pngpaths[tex])
                    # Flaky PILlow bug causing unclosed fp loss during convert
                    # resulting in a Too many files open IOError
                    inpfp = inp.fp
                    inp2 = inp.convert('RGBA')
                    ind = inp2.load()
                    inpfp.close()
                    pixcount = 0
                    ccumul = [0, 0, 0, 0]
                    for x in range(inp.size[0]):
                        for y in range(inp.size[1]):
                            pxl = ind[x, y]
                            ccumul[0] += (pxl[0]*pxl[3])/255
                            ccumul[1] += (pxl[1]*pxl[3])/255
                            ccumul[2] += (pxl[2]*pxl[3])/255
                            ccumul[3] += pxl[3]
                    a = ccumul[3]/255
                    if a > 0:
                        for i in range(3):
                            ccumul[i] /= a
                    if r_override is not None:
                        ccumul[0] = r_override
                    if g_override is not None:
                        ccumul[1] = g_override
                    if b_override is not None:
                        ccumul[2] = b_override
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
