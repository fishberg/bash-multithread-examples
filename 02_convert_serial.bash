#!/usr/bin/env bash

for infile in $(ls svg); do
    ./01_convert.bash $infile
done
