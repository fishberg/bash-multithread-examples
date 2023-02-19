#!/usr/bin/env bash

# parallel installed by:
# sudo apt install parallel

ls svg | parallel -j $(nproc) ./01_convert.bash {}
