# [Chapter 4: Case Study - Interface Design](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap04)

## Getting Started

If necessary, install packages (you'll probably need them, this uses `Colors` and [`Luxor` turtle graphics](https://juliagraphics.github.io/Luxor.jl/v0.11/turtle.html)):

```bash
julia packages.jl
```

## Exercises

Code is contained in the `src/` directory. All exercises are implemented as a
Julia module (`src/Exercises.jl`) which may be ran as a main script for
demonstration (`src/main.jl`).

It felt a little awkward to write tests for turtle graphics. This could be done
by writing `.svg` files and comparing to ones generated ahead of time; but this
feels like overkill for a simple demo of turtle graphics. 🤷‍♂️

## Documentation

A web page describing these can be built using `Documenter.jl`. The
`docs/make.jl` script can be used to build this page.

```bash
cd docs/
julia make.jl
xdg-open build/index.html
```
