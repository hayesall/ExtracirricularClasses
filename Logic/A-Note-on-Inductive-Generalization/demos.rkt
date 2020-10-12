; Copyright © 2020 Alexander L. Hayes

#lang racket

(require "inductive-generalization.rkt")


(define demo1
  '(Literal "P" ((Function "x"
                      ((Variable "y")
                       (Variable "z"))))))

(define demo2
  '(Literal "P" ((Function "b"
                      ((Variable "y")
                       (Variable "x"))))))

;(define demo1 '(Literal "P" ((Function "a" ()))))
;(define demo2 '(Literal "P" ((Function "b" ()))))

;;; These were from the Plotkin 1970 paper:

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

(define demo3
  '(Literal "P" (Function "f" ((Variable "a") (Variable "b") (Variable "c")))))
(define demo4
  '(Literal "P" (Function "b" ((Variable "a") (Variable "b") (Variable "d")))))

#|

(display-word W₁)
(display-word W₂)
(unflatten
  (find-term W₁ W₂))
(exit)

(for-each (λ (x) (printf "~a\n" x))
  (find-term W₁ W₂))

(exit)



(display-word demo3)
(display-word demo4)
(find-term demo3 demo4)

(for-each (λ (x) (printf "~a\n" x))
  (find-term demo3 demo4))

; (clean (find-term demo1 demo2))
; (clean (find-term W₁ W₂))


(exit)
|#

(define (main)
 (printf "Original Words:\n\n")
 (printf (display-word W₁))
 (printf "\n")
 (printf (display-word W₂))
 (printf "\n")

 (printf "\nAnti-unified Word:\n\n")
 (printf (display-word (antiunify W₁ W₂)))
 (printf "\n")
 )

(main)
