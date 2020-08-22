; Copyright 2020 Alexander L. Hayes
; MIT License

#lang racket

(define (var name) (vector name))
(define (var? x) (vector? x))

(define (walk v s)
  (let ((a (and (var? v) (assv v s))))
    (cond
      ((pair? a) (walk (cdr a) s))
      (else v))))

; Variables

(define x (var 'x))
(define y (var 'y))
(define z (var 'z))

; Associations:
(cdr `(,z . b))
(cdr `(,z . (,x e ,y)))
