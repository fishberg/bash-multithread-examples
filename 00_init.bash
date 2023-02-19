#!/usr/bin/env bash

git submodule init
git submodule update

cp twemoji/assets/svg/*.svg svg
rm -f png/*.png
