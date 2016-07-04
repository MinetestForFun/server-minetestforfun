#!/bin/env python2

from __future__ import print_function
import sys, os, subprocess
from os import listdir
from os.path import isfile, join, sep

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def which(program):
    import os
    def is_exe(fpath):
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

    fpath, fname = os.path.split(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            path = path.strip('"')
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file

    return None

try:
    from PIL import Image
except ImportError:
    eprint("Could not import PIL, is it installed ?")
    sys.exit(1)

uskins_path = "u_skins"
meta_path = join(uskins_path, "meta")
textures_path = join(uskins_path, "textures")
pngcrush = which('pngcrush')
optipng = which('optipng')

def process_copies(src, dst, copies):
    for copy in copies:
        srcrect = copy[0]
        dstrect = copy[1]
        flip = copy[2] if len(copy) > 2 else None
        region = src.crop(srcrect)
        if flip is not None:
            region = region.transpose(flip)
        dst.paste(region, dstrect)

def make_preview(src, dst):
    skin = Image.open(src)
    preview = Image.new('RGBA', (16, 32))
    process_copies(skin, preview, [
        [(8, 8, 16, 16), (4, 0)], # Head
        [(44, 20, 48, 32), (0, 8)], # Left arm
        [(44, 20, 48, 32), (12, 8), Image.FLIP_LEFT_RIGHT], # Right arm
        [(20, 20, 28, 32), (4, 8)], # Body
        [(4, 20, 8, 32), (4, 20)], # Left leg
        [(4, 20, 8, 32), (8, 20), Image.FLIP_LEFT_RIGHT], # Right leg
    ])
    overlay = Image.new('RGBA', (16, 32))
    process_copies(skin, overlay, [
        [(40, 8, 48, 16), (4, 0)], # Head
    ])
    preview = Image.alpha_composite(preview, overlay)
    preview.save(dst)
    if optipng is not None:
        p = subprocess.Popen([optipng, '-o7', '-quiet', dst])
        p.wait()
    elif pngcrush is not None:
        p = subprocess.Popen([pngcrush, '-ow', '-s', dst])
        p.wait()

if __name__ == '__main__':
    metas = [f for f in listdir(meta_path) if
             isfile(join(meta_path, f)) and
             f.endswith(".txt")]
    for meta in metas:
        f = open(join(meta_path, meta), 'r')
        metadata = f.read().splitlines()
        f.close()
        skin = meta[:-4]
        print("Processing {} \"{}\" by {} ({})...".format(skin, metadata[0], metadata[1], metadata[2]))
        make_preview(join(textures_path, skin + ".png"), join(textures_path, skin + "_preview.png"))
