#lang racket

(require "inductive-generalization.rkt")

(define W₁
  '(Literal "¬Occ" ((Function "2" ()) (Function "O" ()) (Function "p₁" ()))))

(define W₂
  '(Literal "¬Occ" ((Function "2" ()) (Function "X" ()) (Function "p₂" ()))))

(print-word W₁)
(print-word W₂)

(print-word (antiunify W₁ W₂))


(define win₁ '(Literal "Win" ((Function "p₁" ()))))
(define win₂ '(Literal "Win" ((Function "p₂" ()))))

(print-word win₁)
(print-word win₂)
(print-word (antiunify win₁ win₂))

; Alternative representation for words:

; This is slightly less verbose while still being easy to parse.
(define α
  '(¬Occ ((pos2 ()) (O ()) (p₁ ()))))
(define β
  '(¬Occ ((pos2 ()) (X ()) (p₂ ()))))

(define (altword->string w)
  (match w
    [`(,F ,args) #:when (and (symbol? F) (list? args))
      (string-append (symbol->string F) "(" (altword->string args) ")")]
    [`,var #:when (symbol? var)
      (symbol->string var)]
    [`,var #:when (number? var)
      (number->string var)]
    [(cons a d)
      (if (null? d)
          (altword->string a)
          (string-append (altword->string a) ", " (altword->string d)))]
    ['() ""]))

(altword->string α)
(altword->string β)

; This is more Lispy. But the non-Curried syntax makes it a little less elegant.

(define γ
  '(¬Occ (pos2) (O) (p₁ a b c)))
(define δ
  '(¬Occ (pos2) (X) (p₂ a b)))

(define (expr->expr W)
  (match W
    [`,var #:when (symbol? var) var]
    [(cons a d)
      (cons a d)]
    ['() '()]))

(define (expr->string W)
  (match W
    [`,var #:when (symbol? var) (string-append "(Variable " (symbol->string var) ")")]
    [(cons a d) #:when (and (symbol? a) (pair? d))
      (string-append (expr->string a) (expr->string d))]
    [(cons a '()) #:when (symbol? a)
      (string-append "((Function " (symbol->string a) ") ())")]
    ['() ""]
    [_ (error "Cannnot handle" W)]
  ))

γ
(expr->expr γ)
(expr->string γ)
