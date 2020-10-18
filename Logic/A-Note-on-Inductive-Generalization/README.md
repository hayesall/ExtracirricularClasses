# A Note on Inductive Generalization

Provides an [anti-unification method](https://en.wikipedia.org/wiki/Anti-unification_(computer_science)) finding the least general generalization (lgg)
of two words based on Plotkin's Theorem 1.

## Example

```racket
#lang racket

(require "inductive-generalization.rkt")

(define W₁
  '(Literal "P" ((Variable "a"))))
(define W₂
  '(Literal "P" ((Variable "b"))))

(print-word W₁)
(print-word W₂)
(print-word
  (antiunify W₁ W₂))
```

**Result**. This will print W₁ and W₂, then the lgg of the two
words: a literal with a new variable "0".

```console
P(a)
P(b)
P(_0)
```

## References

1. G. Plotkin. "A Note on Inductive Generalization." In *Machine Intelligence*,
  volume 5, pages 153-163. Edinburgh University Press, 1970.
