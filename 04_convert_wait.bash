#!/usr/bin/env bash

for infile in $(ls svg); do
    if [ $(jobs | wc -l) -ge $(nproc) ] ; then
        wait
    fi
    ./01_convert.bash $infile &
done
