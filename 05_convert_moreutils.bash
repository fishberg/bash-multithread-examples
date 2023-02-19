#!/usr/bin/env bash

# parallel installed by:
# sudo apt install moreutils

parallel.moreutils -j $(nproc) -i bash -c "./01_convert.bash {} \;" -- $(ls svg)
