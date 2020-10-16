; Copyright © 2020 Alexander L. Hayes

#lang racket

(require "inductive-generalization.rkt")

; P(f(a(), g(y)), m, g(y))
(define W₁
  '(Literal "P" ((Function "f"
                           ((Function "a" ())
                            (Function "g" (Variable "y"))))
                 (Variable "m")
                 (Function "g" (Variable "y"))
                 )))

; P(h(a(), g(x)), m, g(x))
(define W₂
  '(Literal "P" ((Function "h"
                           ((Function "a" ())
                            (Function "g" (Variable "x"))))
                 (Variable "m")
                 (Function "g" (Variable "x"))
                 )))

(define (main)
 (printf "Original Words:\n\n")
 (print-word W₁)
 (print-word W₂)

 (printf "\nAnti-unified Word:\n\n")
 (print-word (antiunify W₁ W₂))
 (printf "\n")
 )

(main)
