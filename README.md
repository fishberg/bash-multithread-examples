# bash-multithread-examples (w/ Twemoji)

Simple set of examples showing how to easily multi-thread bash scripts.  
As a sample load-heavy yet parallelizable task, we will convert the [Twemoji](https://github.com/twitter/twemoji) set of [SVG assets](https://github.com/twitter/twemoji/tree/master/assets/svg) into 500x500 PNGs. 

## 1. Install Dependencies
Assuming you're on Ubuntu 20.04:
```bash
# install inkscape for SVG to PNG conversion
sudo apt install inkscape

# inkscape throws lots of warnings (but not errors) if these libraries are missing
sudo apt install libcanberra-gtk-module libcanberra-gtk3-module

# install GNU parallel and moreutils
sudo apt install parallel moreutils
```
* Note: Both the `parallel` and `moreutils` packages install a program called `parallel` on your system. If both are installed, the former (which installs GNU parallel) remains `parallel` and `moreutils` program becomes `parallel.moreutils`.

## 2. Initialize
Run the script:
```bash
./00_init.bash
```
to set up the [Twemoji](https://github.com/twitter/twemoji) submodule, copy SVG files into `./svg` for processing, and clear `./png` of any PNG files.
* Last tested on [Twemoji](https://github.com/twitter/twemoji) commit `d94f4cf793e6d5ca592aa00f58a88f6a4229ad43`

## 3. Run a script
| Script | Benchmark | Description |
| ------ | --------- | ----------- |
| `01_convert.bash` | N/A | Takes name of SVG file in `./svg` converts it PNG and saves it to `./png`. Helper script used by all later scripts. |
| `02_convert_serial.bash` | 22m48.716s | Serially converts all SVGs to PNGs. |
| `03_convert_while-loop.bash` | 1m35.523s | Runs conversions as background jobs until `# active jobs = # processors`. Polls jobs until one finishes, then starts another. |
| `04_convert_wait.bash` | 1m51.160s | Runs conversions as background jobs until `# active jobs = # processors`. Uses `wait` to block until all background jobs complete, then starts a new batch. |
| `05_convert_moreutils.bash` | 1m28.400s | Uses `parallel.moreutils` to parallelize. |
| `06_convert_parallel.bash` | 1m27.282s | Uses `parallel` (i.e. GNU parallel) to parallelize. |
* Although there are valid uses for each method, GNU parallel's `parallel` is probably my favorite. Both `parallel` and `parallel.moreutils` have a `make -j` like interface, but I find `parallel`'s syntax slightly more versatile/intuitive. Furthermore, as a GNU tool, it is probably more widely used.

## Benchmarking System
Benchmarking was run on the following system:
```
OS: Ubuntu 20.04.2 LTS x86_64 
Host: Alienware Aurora R11 1.0.1 
Kernel: 5.15.0-58-generic 
Shell: bash 5.0.17 
CPU: Intel i9-10900K (20) @ 5.300GHz 
GPU: NVIDIA GeForce RTX 2080 SUPER 
Memory: 64109MiB 
```

## Reference Used
* [bash change file extension](https://stackoverflow.com/questions/9590935/change-extension-of-file-using-shell-script)
* [parameter expansion](https://devhints.io/bash)
* [$() vs ${}](https://stackoverflow.com/questions/27472540/difference-between-and-in-bash)
* [inkscape convert svg to png](https://stackoverflow.com/questions/9853325/how-to-convert-a-svg-to-a-png-with-imagemagick)
* [multi-threading bash](https://stackoverflow.com/questions/6511884/how-to-limit-number-of-threads-sub-processes-used-in-a-function-in-bash)
* [GNU parallel tutorial](https://bash-prompt.net/guides/parallell-bash/)

## TODO
* Add a `sem` example (part of GNU parallel). [1](https://stackoverflow.com/a/8740582) [2](https://unix.stackexchange.com/a/216466)
* Add a `wait -n` example. [1](https://linuxize.com/post/bash-wait/) [2](https://stackoverflow.com/questions/69233150/does-bash-wait-command-support-n-option)
    * Note: We are using `wait` as implemented by the bash shell, thus its documentation shown with `help wait`. This is not to be confused with the `wait` binary, whose documentation is shown with `man wait`.
