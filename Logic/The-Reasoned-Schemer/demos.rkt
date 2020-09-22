; Copyright 2020 Alexander L. Hayes
;
; This is heavily notes from the book at the moment.

#lang racket/load
(load "trs2-impl.rkt")


(defrel (caro p a)
  (fresh (d)
         (== (cons a d) p)))

(defrel (cdro p d)
  (fresh (a)
         (== (cons a d) p)))

(defrel (conso a d p)
  (== `(,a . ,d) p))

(defrel (nullo x)
  (== '() x))

(defrel (pairo p)
  (fresh (a d)
         (conso a d p)))

; p. 33
(define (singleton? l)
  (cond
    ((pair? l) (null? (cdr l)))
    (else #f)))

; The Translation (Initial) (p. 34)
; ---------------------------------
;
; To translate a function into a relation, first replace `define` with
; `defrel`. Then unnest each expression in each `cond` line, and
; replace each `cond` with `conde`.
;
; To unnest a `#t`, replace it with `#s` (`success`). To unnest a
; `#f`, replace it with a `#u` (`fail`).

(print

 (run* r
       (fresh (x y z)
              (== `(e a d ,x) r)
              (conso y `(a ,z c) r)))

 )

(printf "\n")
