#!/bin/sh
#
# Script to chmod all files in the repository at 755
# Script ßý LeMagnesium
#

# Go to repo root
mydir="`dirname "$0"`"
test -d "$mydir" && cd "$mydir/../../"

# CHMOD TIME!
chmod -R 755 .
echo "All files have been chmod-ed to mode 755."

#EOF
