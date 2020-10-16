; Copyright © 2020 Alexander L. Hayes

#lang racket

; TODOs:
;   1. Show exactly what the trees look like in this parsing model.
;      (e.g. "these are the possible terms.")
;   2. Find/write a formatter

; Suppose there is no `cons` operator in your language.
; and you want to model something after clojure, except you want a cons:
(define-syntax mycons
  (syntax-rules ()
    ((mycons a b) (cons a b))))

; Now suppose you want something called "Term"
; that takes two arguments and returns it as a cons pair
; (i.e. with a tag).

(define-syntax Term
  (syntax-rules ()
    ((Term a b) `(mycons ,a ,b))))

; Now you have a little parser!

(Term 3 (Term 4 5))

; Possibly useful when reasoning about Racket code
; in a setting where functions must have names:
; `rec` can act like a named-λ.
; Consider the following `rec` and `let` blocks:

(require mzlib/etc)

((rec name (λ (x)
            (cond
              ((zero? x) 1)
              (else (* x (name (sub1 x)))))))
  5)

(let name ((n 5))
  (cond
    ((zero? n) 1)
    (else (* n (name (sub1 n))))))
