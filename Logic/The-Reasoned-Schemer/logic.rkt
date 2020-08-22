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

;;; p. 166
(define (walk* v s)
  (let ((v (walk v s)))
    (cond
      ((var? v) v)
      ((pair? v)
       (cons
        (walk* (car v) s)
        (walk* (cdr v) s)))
      (else v))))

(define (ext-s x v s)
  (cond
    ((occurs? x v s) #f)
    (else (cons `(,x . ,v) s))))

(define (occurs? x v s)
  (let ((v (walk v s)))
    (cond
      ((var? v) (eqv? v x))
      ((pair? v)
       (or (occurs? x (car v) s)
           (occurs? x (cdr v) s)))
      (else #f))))

(define (unify u v s)
  (let ((u (walk u s)) (v (walk v s)))
    (cond
      ((eqv? u v ) s)
      ((var? u) (ext-s u v s))
      ((var? v) (ext-s v u s))
      ((and (pair? u) (pair? v))
       (let ((s (unify (car u) (car u) s)))
         (and s
              (unify (cdr u) (cdr v) s))))
      (else #f))))

(define (equiv u v)
  (λ (s)
    (let ((s (unify u v s)))
      (if s `(,s) '()))))

(define oct-s
  ; This is ``#s`` in the book
  (λ (s)
    `(,s)))

(define oct-u
  ; This is ``#u`` in the book
  (λ (s)
    '()))

; p. 156
(define (disj_2 g_1 g_2)
  (λ (s)
    (append_inf (g_1 s) (g_2 s))))

(define (append_inf s_inf t_inf)
  (cond
    ((null? s_inf) t_inf)
    ((pair? s_inf)
     (cons (car s_inf)
           (append_inf (cdr s_inf) t_inf)))
    (else (λ ()
            (append_inf t_inf (s_inf))))))

; p. 163
(define (conj_2 g_1 g_2)
  (λ (s)
    (append_map_inf g_2 (g_1 s))))

(define (append_map_inf g s_inf)
  (cond
    ((null? s_inf) '())
    ((pair? s_inf)
     (append_inf (g (car s_inf))
                 (append_map_inf g (cdr s_inf))))
    (else (λ ()
            (append_map_inf g (s_inf))))))

(define (nevero)
  (λ (s)
    (λ ()
    ((nevero) s))))

(define (alwayso)
  (λ (s)
    (λ ()
      ((disj_2 oct-s (alwayso)) s))))

(define (take_inf n s_inf)
  (cond
    ((and n (zero? n)) '())
    ((null? s_inf) '())
    ((pair? s_inf)
     (cons (car s_inf)
           (take_inf (and n (sub1 n))
                     (cdr s_inf))))
    (else (take_inf n (s_inf)))))

;;; We define `call/fresh` to introduce variables.
;;; Although *name* is used, it is ignored.
;;;
;;; `call/fresh` expects its second argument to be
;;; a lambda expression. More specifically, that
;;; lambda expression should expect a variable and
;;; produce a goal. That goal then has access to
;;; the variable just created.
(define (call/fresh name f)
  (f (var name)))

;;; When would it make sense to use distinct symbols
;;; for variables? When we *present* values.
;;;
;;; Every variable that we present is represented as
;;; a corresponding symbol: an underscore followed by
;;; a natural number. We call these symbols
;;; *reified variables*.
;;;
;;; How can we create a reified variable given a
;;; number?
(define (reify-name n)
  (string->symbol
   (string-append "_"
                  (number->string n))))

;;; "Pro-ject" Macro (p. 166)
;;; **project** behaves like **fresh**, but it binds
;;; different values to the lexical variables.
;;; **project** binds walk*'d values, whereas
;;; **fresh** binds variables using *var*.
(define-syntax project
  (syntax-rules ()
    ((project (x ...) g ...)
     (λ (s)
       (let ((x (walk* x s)) ...)
         ((conj g ...) s))))))

;;; Here is *reify-s*, which initially expects a
;;; value v and an empty reified-name
;;; substitution *r*.
;;;
;;; What definition is *reify-s* reminiscent of?
;;; *unify*: *reify-s*, unlike *unify*, expects
;;; only one value in addition to a substitution.
;;; Also, *reify-s* cannot produce ``#f``. But
;;; like *unify*, *reify-s* begins by *walking*
;;; *v*. Then in both cases, if the *walk*'d v is
;;; a variable, we know it is fresh and we use
;;; that fresh variable to extend the substitution.
;;;
;;; Unlike in *unify*, no *occurs?* is needed in
;;; *reify-s*. In both cases, if *v* is a pair,
;;; we first produce a new substitution based on
;;; the *car* of the pair. That substitution can
;;; then be extended using the *cdr* of the pair.
;;; And, there is a case where the substitution
;;; remains unchanged.
(define (reify-s v r)
  (let ((v (walk v r)))
    (cond
      ((var? v)
       (let ((n (length r)))
         (let ((rn (reify-name n)))
           (cons `(,v . ,rn) r))))
      ((pair? v)
       (let ((r (reify-s (car v) r)))
         (reify-s (cdr v) r)))
      (else r))))

(define (reify v)
  (λ (s)
    (let ((v (walk* v s)))
      (let ((r (reify-s v empty-s)))
        (walk* v r)))))

(define (run-goal n g)
  (take_inf n (g empty-s)))

;;; ## Macros from p. 177
(define-syntax disj
  (syntax-rules ()
    ((disj) oct-u)
    ((disj g) g)
    ((disj g0 g ...) (disj_2 g0 (disj g ...)))))

(define-syntax conj
  (syntax-rules ()
    ((conj) oct-s)
    ((conj g) g)
    ((conj g0 g ...) (conj_2 g0 (conj g ...)))))

(define-syntax defrel
  (syntax-rules ()
    ((defrel (name x ...) g ...)
     (define (name x ...)
       (λ (s)
         (λ ()
           ((conj g ...) s)))))))

#|
(define-syntax run
  (syntax-rules ()
    ((run n (x0 x ...) g ...)
     (run n q (fresh (x0 x ...)
                     (equiv `(,x0 ,x ...) q) g ...)))
    ((run n q g ...)
     (let ((q (var 'q)))
       (map (reify q)
            (run-goal n (conj q ...)))))))

(define-syntax run*
  (syntax-rules ()
    ((run* q g ...) (run #f q g ...))))
|#

(define-syntax fresh
  (syntax-rules ()
    ((fresh () g ...) (conj g ...))
    ((fresh (x0 x ...) g ...)
     (call/fresh 'x0
                 (λ (x0)
                   (fresh (x ...) g ...))))))

(define-syntax conde
  (syntax-rules ()
    ((conde (g ...) ...)
     (disj (conj g ...) ...))))

; Variables

(define empty-s '())

(define u (var 'u))
(define v (var 'v))
(define w (var 'w))

(define x (var 'x))
(define y (var 'y))
(define z (var 'z))

; Associations:
; (cdr `(,z . b))
; (cdr `(,z . (,x e ,y)))

#|
(walk x
      `((,x . ,y) (,v . ,x) (,w . ,x)))

(walk w
      `((,x . b) (,z . ,y) (,w . (,x e ,z))))
|#

((equiv #t #f) empty-s)
(oct-u empty-s)
((equiv x y) empty-s)

;
(take_inf 3 ((alwayso) empty-s))

;; What is the value of this?
(let ((k (length
          (take_inf 5
                    ((disj_2 (equiv 'olive x) (equiv 'oil x))
                     empty-s)))))
  `(Found ,k not 5 substitutions))

;;
(take_inf 1
          ((call/fresh 'kiwi
                       (λ (fruit)
                         (equiv 'plum fruit)))
           empty-s))


;;
(let ((a1 `(,x . (,u ,w ,y ,z ((ice) ,z))))
      (a2 `(,y . corn))
      (a3 `(,w . (,v ,u))))
  (let ((s `(,a1 ,a2 ,a3)))
    ((reify x) s)))

;;
(map (reify x)
     (take_inf 5
               ((disj_2 (equiv 'olive x) (equiv 'oil x))
                empty-s)))

(map (reify x)
     (run-goal 5
               (disj_2 (equiv 'olive x) (equiv 'oil x))))
