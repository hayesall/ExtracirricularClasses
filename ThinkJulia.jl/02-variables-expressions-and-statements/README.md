# [Chapter 2: Variables, Expressions, and Statements](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap02)

## Exercises

Code is contained in the `src/` directory. All exercises are implemented as a
Julia module (`src/Exercises.jl`) which may be ran as a main script for
demonstration (`src/main.jl`) and tested for correctness (`src/tests.jl`).

```bash
$ cd src/
$ julia --color=yes tests.jl
```

## Documentation

A web page describing these can be built using `Documenter.jl`. The
`docs/make.jl` script can be used to build this page.

Install Documenter:

```bash
(v1.1) pkg> add Documenter
(v1.1) pkg> precompile
```

Build the page:

```bash
$ cd docs/
$ julia --color=yes make.jl
$ open -a "Firefox" build/index.html
```
