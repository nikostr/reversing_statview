# Reverse engineering StatView binaries to rescue old data

[![DOI](https://zenodo.org/badge/662536997.svg)](https://zenodo.org/badge/latestdoi/662536997)

This repo contains a minimal rescue of data from 

Read, Andrew F., and Paul H. Harvey. “Reassessment of Comparative Evidence for Hamilton and Zuk Theory on the Evolution of Secondary Sexual Characters.” Nature 339, no. 6226 (June 1989): 618–20. https://doi.org/10.1038/339618a0.

with column headings inferred with the help of

Read, Andrew F. “Passerine Polygyny: A Role for Parasites?” The American Naturalist 138, no. 2 (August 1991): 434–59. https://doi.org/10.1086/285225.

The original data is present in the StatView files present in the `data` directory. All of the code to read the data is hacky: `read_float80.cpp` contains Rcpp code to convert `float80` to R `double`, and `read_binary.R` reads the data into R tibbles. A bunch of stuff (column names, the content of string columns, endianness) is hard-coded since I couldn't figure out the exact formatting of the StatView headers and couldn't be bothered to implement a way of reading the string columns, etc. Given the presence of truncated strings in what seems to be the StatView column specification there might also be reason to suspect that the files have in some way been corrupted since their creation. 

The cleaned datasets are available at [doi:10.5281/zenodo.8117246](https://doi.org/10.5281/zenodo.8117246) and [doi:10.5281/zenodo.8116290](https://doi.org/10.5281/zenodo.8116290) respectively. This data was recovered by Nikos Tsardakas Renhuldt (me) and Tamara Emmenegger with input from Andrew Read.

## Some notes on the StatView format

Theses are some things I think I've figured out regarding the StatView format:

* The 4th byte provides the number of rows of data
* The 8th byte provides the number of columns
* The overall file structure consists in a header definition providing column names (and probably column types, but I haven't figured out how these are encoded) followed by each column of data.
* Strings are preceded by the number of bytes the string contains.

A more comprehensive writup of how I did this is available at [my blog](https://nikostr.github.io/reverse-engineering/2023/07/05/reverse-engineering-statview-files.html).
