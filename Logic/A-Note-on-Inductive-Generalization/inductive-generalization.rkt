; Copyright © 2020 Alexander L. Hayes
; MIT License

#|
Overview
--------

The algorithm described in Plotkin's "Theorem 1" is described in
an imperative style. This rewrites some of Plotkin's explanation
in a Lispy style.

Foundations
'''''''''''

Suppose we can show that a property holds for variables and constants,
and that whenever it holds for t₁, ..., tₙ then it holds for
ϕ(t₁, ..., tₙ).

Then the property holds for all words.

We will write W₁ ∼ W₂ when W₁ ≤ W₂ and W₂ ≤ W₁. It is known that 
W₁ ∼ W₂ are alphabetic variants.

Two words are *compatible* ⇔ they are both terms or have the same
predicate sign or letter.

If K is a set of words, then W is a *least generalization* of K ⇔

1. For every V in K, W ≤ V.
2. If for every V in K, W₁ ≤ V, then W₁ ≤ W.

It follows from (2) that if W₁,W₂ are any two least generalizations
of K, then W₁ ∼ W₂.

Theorem 1
'''''''''

Every non-empty, finite set of words has a least generalization
⇔ any two words in the set are compatible.

Let W₁, W₂ be any two compatible words.

1. Set Vᵢ to Wᵢ(i=1,2).
   Set εᵢ to ε (i=1,2).
   ε is the empty substitution.

2. Try to find terms t₁, t₂ which have the same place in V₁, V₂
   respectively and such that t₁ ≠ t₂ and either t₁ and t₂ begin
   with different function letters or else at least one of them
   is a variable.

3. If there are no such t₁, t₂ then halt. V₁ is a least
   generalization of {W₁, W₂} and V₁ = V₂, Vᵢεᵢ = Wᵢ(i=1,2).

4. Choose a variable `x` distinct from any in V₁ or V₂ and 
   wherever t₁ and t₂ occur in the same place in V₁ and V₂,
   replace each by `x`.

5. Change εᵢ to {tᵢ|x} εᵢ(i=1,2).

6. Go to 2.

Bibliography
------------

1. G. Plotkin. "A Note on Inductive Generalization."
   In *Machine Intelligence*, volume 5, pages 153-163.
   Edinburgh University Press, 1970.
2. Luc De Raedt, Peter Idestam-Almquist, Gunther Sablon.
   "Θ-subsumption for Structural Matching."
   European Conference on Machine Learning (ECML),
   pages 73-84. Lecture Notes in Computer Science, 1997.
|#

#lang racket

; TODO(hayesall): `compatible?` function that checks two words
; TODO(hayesall): Substitutions are managed differently than how they are in `mk.rkt`

(define display-word
  (λ (w)
    (match w
      [`(Literal ,f ,a)
       (string-append f "(" (display-word a) ")")]
      [`(Term ,f ,a)
       (string-append f "(" (display-word a) ")")]
      [`(Term ,f)
       f]
      [`(Variable ,z)
       ; Variables as numbers?
       ; TODO(hayesall): There might be a `reify` analogy here.
       (string-append "_" z)]
      [(cons a '())
       (string-append (display-word a))]
      [(cons a b)
       (string-append (display-word a) ", " (display-word b))]
      ['() ""]
      )))

; P(f(a(), g(y)), x, g(y))
(define W₁
  '(Literal "P" ((Term "f"
                       ((Term "a" ())
                        (Term "g" (Term "y"))))
                 (Term "x")
                 (Term "g" (Term "y"))
                 )))

; P(h(a(), g(x)), x, g(x))
(define W₂
  '(Literal "P" ((Term "h"
                       ((Term "a" ())
                        (Term "g" (Term "x"))))
                 (Term "x")
                 (Term "g" (Term "x"))
                 )))
#;
(define W₃
  '(Literal "P" ((Term "h"
                       ((Term "a" ())
                        (Term "g" (Variable "z"))))
                 (Term "x")
                 (Term "g" (Variable "z")))))

#;
(define W₄
  '(Literal "P" ((Variable "y") (Term "x") (Term "g" (Variable "z")))))

(define W₅
  '(Term "f" ((Term "a" ()) (Term "g" (Variable "z")))))
(define W₆
  '(Term "h" ((Term "a" ()) (Term "g" (Variable "z")))))


(display-word W₁)
(display-word W₂)

(display-word W₅)
(display-word W₆)
