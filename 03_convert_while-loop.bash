#!/usr/bin/env bash

for infile in $(ls svg); do
    while [ $(jobs | wc -l) -ge $(nproc) ] ; do sleep .1 ; done
    ./01_convert.bash $infile &
done
