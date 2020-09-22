# Logic and Logic Programming

This mostly comes out of discussion with Dan Friedman.

## Books or References

- The Reasoned Schemer
  - See also: [The Second Edition Repository](https://github.com/TheReasonedSchemer2ndEd/CodeFromTheReasonedSchemer2ndEd)
- A Note on Inductive Generalization

## Getting Started

Currently this repository assumes a [Racket](https://racket-lang.org/) development
environment is available.

Currently (2020-08-22), the `racket/bin` directory is not automatically appended
to your path, so add something like the following to your `.bashrc`:

```bash
export PATH="$HOME/Languages/racket/bin:$PATH"
```

## Some Quick Notes on SLaTeX

A `slatex` executable is installed in the `racket/bin/` directory&mdash;but there
is not much documentation out there for working with this tool.

I've organized some notes here, and will add more as I find them.

### TeXLive on Ubuntu

You'll need a `TeXLive` distribution (i.e., access to `latex`, `bibtex`, etc. on your path).

If you don't already have it, install:

```bash
sudo apt install texlive-latex-base
```

### Introducing slatex

`\usepackage{slatex}` provides access to several definitions:

- `\scheme{}`
- `\begin{schemedisplay} ... \end{schemedisplay}`

However, running `pdflatex` in hopes of producing a `.pdf` will likely raise an error:

```console
! LaTeX Error: File `slatex.sty' not found.
```

The `slatex` binary is installed alongside Racket. Your `pdflatex` either needs to be
told about the `slatex.sty` file, or you need to build your `.pdf` the manual way.

On my machine, `slatex.sty` was installed here:

```console
/home/hayesall/Languages/racket/share/pkgs/slatex/./slatex.sty
```

`slatex` can find it, so you can build a pdf with the following:

```bash
slatex test.tex
dvipdfm test.dvi
```

### Links that helped me

- [SLaTeX Wrapper (in Racket docs)](https://docs.racket-lang.org/slatex-wrap/index.html)
- [GitHub /racket/slatex](https://github.com/racket/slatex)

I picked up some notes on formatting from
[Sam's test cases](https://github.com/racket/slatex/blob/master/tests/slatex/test.rkt).
