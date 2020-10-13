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

(provide display-word
         antiunify
         find-term
         cleanup
         substitute
         )

; TODO(hayesall): `compatible?` function that checks two words
; TODO(hayesall): Substitutions are managed differently than how they are in `mk.rkt`
; TODO(hayesall): The "cleanup" function exists because the `find-terms` function needs re-thinking.

(define (display-word w)
  (match w
    [`(Literal ,L ,a)
     (string-append L "(" (display-word a) ")")]
    [`(Function ,f ,a)
      (cond
        [(string? f) (string-append f "(" (display-word a) ")")]
        [else (string-append "_" (number->string f) "(" (display-word a) ")")])]
    [`(Variable ,z)
      (cond
        [(string? z) z]
        [else (string-append "_" (number->string z))])]
    [(cons a b)
     (cond
       [(null? b) (display-word a)]
       [else (string-append (display-word a) ", " (display-word b))])]
    ['() ""]
    [_ (error "ohno" w)]
    ))

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
    ['() '()]
    [_ (error "bad data") W]
    ))

(require racket/trace)
(define (find-term V₀ V₁)
  ; We can match V₀ because the two words are *compatible.*
  ; TODO(hayesall): This finds **all** possible terms. Make Lazy?
  (match V₀
    [`(Literal ,symbol ,body)
      (find-term body (caddr V₁))]
    [`(Function ,symbol ,body)
      (cond

        ; If the symbols are unequal, but the bodies are equal:
        [(and
          (not (equal? symbol (cadr V₁)))
          (equal? body (caddr V₁)))
          `((Function ,symbol ,body) (Function ,(cadr V₁) ,(caddr V₁)))]

          ; Otherwise, look for matching terms in the bodies.
        [else (find-term body (caddr V₁))]
        )]
    [`(Variable ,symbol)
      ; The only case we care about is when two variables have different names.
      (cond
        [(not (equal? symbol (cadr V₁)))
          `((Variable ,symbol) (Variable ,(cadr V₁)))]
        [else '()]
        )]
    [(cons a b)
      (cons (find-term a (car V₁)) (find-term b (cdr V₁)))]
    ['() '()]
    [_ (error "bad data" V₀ V₁)]
    ))

(define (cleanup ls)
  (cond
    [(null? ls) '()]
    [(null? (car ls)) (cleanup (cdr ls))]
    [(member '() (car ls)) (cleanup (cdr ls))]
    [else (cons (car ls) (cleanup (cdr ls)))]))


(define (antiunify-helper V₁ V₂ η)
  (cond
    [(equal? V₁ V₂) V₁]
    [else
      (let* ([subst  (cleanup (find-term V₁ V₂))]
             [subst₁ (caar  subst)]
             [subst₂ (cadar subst)])

             (antiunify-helper
               (substitute V₁ subst₁ `(Variable ,η))
               (substitute V₂ subst₂ `(Variable ,η))
               (add1 η)))]))

(define (antiunify V₁ V₂)
  (antiunify-helper V₁ V₂ 0))
