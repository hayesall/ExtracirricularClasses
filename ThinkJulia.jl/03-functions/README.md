# [Chapter 3: Functions](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap03)

## Getting Started

If necessary, install packages:

```bash
julia packages.jl
```

## Exercises

Code is contained in the `src/` directory. All exercises are implemented as a
Julia module (`src/Exercises.jl`) which may be ran as a main script for
demonstration (`src/main.jl`) and tested for correctness (`src/tests.jl`).

```bash
cd src/
julia tests.jl
```

## Documentation

A web page describing these can be built using `Documenter.jl`. The
`docs/make.jl` script can be used to build this page.

```bash
cd docs/
julia make.jl
xdg-open build/index.html
```
