#/usr/bin/env bash

infile=$1
inpath="./svg/$infile"
outpath="./png/${infile%.svg}.png"

# Inkscape older than v1.0 (i.e. Ubuntu 20.04)
COMMAND="inkscape -z -w 500 -h 500 $inpath -e $outpath"

# Inkscape v1.0+
#COMMAND="inkscape -w 500 -h 500 $inpath -o $outpath"

echo $COMMAND
$COMMAND
