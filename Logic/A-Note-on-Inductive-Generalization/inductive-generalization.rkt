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

vLet W₁, W₂ be any two compatible words.

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

(provide word→string
         print-word
         antiunify
         )

; TODO(hayesall): `compatible?` function that checks two words
; TODO(hayesall): Substitutions are managed differently than how they are in `mk.rkt`
; TODO(hayesall): Handle negations ¬P
;   If you wrap a ¬ around the P, does that make P a term?
;     V₁ = P(f(a))
;     V₂ = ¬P(f(a))

; Now that you understand this, you should be able to write a miniKanren
; interpreter by naming the different kinds of variables.
;
; TODOs:
; 1. (let*) is on the list of things to avoid
; 2. Writing as an interpreter (let macros handle your parsing)
; 3. Writing a miniKanren interpreter will allow you to write a program that
;    always finds the most general solution to a problem.
;
; Side Note: "An interpreter is a function you dispatch over other code."
;   e.g. a CPS-er is an interpreter (the left hand side doesn't change,
;        but the right hand side does).
;   "CPS in Little Pieces: Composing Partial Continuations"
;        Γ is a typed environment?
;        "If you do certain things, you can generate the CPS-ed code every
;        time using correctness-preserving-transformations in any order
;        you wish."

(define (print-word w)
  (printf "~a\n" (word→string w)))

(define (word→string W)
  (match W
    [`(Literal ,L ,a) (string-append L "(" (word→string a) ")")]
    [`(Function ,f ,a)
      (if (string? f)
          (string-append f "(" (word→string a) ")")
          (string-append "_" (number->string f) "(" (word→string a) ")"))]
    [`(Variable ,z)
      (if (string? z)
          z
          (string-append "_" (number->string z)))]
    [(cons a b)
     (if (null? b)
         (word→string a)
         (string-append (word→string a) ", " (word→string b)))]
    ['() ""]))

(define (substitute W ε₀ εₙ)
  (match W
    [`(Literal ,symbol ,body)
     `(Literal ,symbol ,(substitute body ε₀ εₙ))]
    [`(Function ,f ,body)
     (cond
       [(equal? ε₀ `(Function ,f ,body)) εₙ]
       [else `(Function ,f ,(substitute body ε₀ εₙ))])]
    [`(Variable ,x)
     (cond
      [(equal? ε₀ `(Variable ,x)) εₙ]
      [else `(Variable ,x)])]
    [(cons a b)
     (cons (substitute a ε₀ εₙ) (substitute b ε₀ εₙ))]
    ['() '()]))

(define (find-terms W₁ W₂)
  (match W₁
    [`(Literal  ,x ,body) (find-terms body (caddr W₂))]
    [`(Function ,f ,body)
      (if [and (not (equal? f (cadr W₂))) (equal? body (caddr W₂))]
          `(((Function ,f ,body) (Function ,(cadr W₂) ,(caddr W₂))))
          (find-terms body (caddr W₂)))]
    [`(Variable ,x)
      (if [not (equal? x (cadr W₂))]
        `(((Variable ,x) (Variable ,(cadr W₂))))
        '())]
    [(cons left right)
      (append (find-terms left (car W₂)) (find-terms right (cdr W₂)))]
    ['() '()]))

(define (antiunify-helper V₁ V₂ η)
  (cond
    [(equal? V₁ V₂) V₁]
    [else
      (let* ([subst  (find-terms V₁ V₂)]
             [subst₁ (caar  subst)]
             [subst₂ (cadar subst)])

             (antiunify-helper
               (substitute V₁ subst₁ `(Variable ,η))
               (substitute V₂ subst₂ `(Variable ,η))
               (add1 η)))]))

(define (antiunify V₁ V₂)
  (antiunify-helper V₁ V₂ 0))
