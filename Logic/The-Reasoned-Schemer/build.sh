#!/usr/bin/env bash

# Copyright 2020 Alexander L. Hayes
# MIT License

# TODO(hayesall): Check return flags for build errors.

(
    cd Chapters
    slatex ch10.tex
    dvipdfm ch10.dvi
    mv ch10.pdf ..
)
