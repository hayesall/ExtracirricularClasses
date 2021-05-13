#lang racket

; https://stackoverflow.com/questions/54621805/visualize-arbitrary-tree-in-racket-using-tree-layout
; https://stackoverflow.com/questions/43480536/racket-export-pict-to-image-file

(require pict
         pict/tree-layout)

(define (my-node a)
  (cc-superimpose
   (disk 35 #:color "white")
   (text (symbol->string a))))

(define (draw atom->pict a)
  (cond ((null? a) #f)                                 ;; 1
        ((list? a) (match a                            ;; 2
                     ((cons op args)
                      (apply tree-layout
                             #:pict (atom->pict op)
                             (map (curry draw atom->pict) args)))
                     (_ #f)))
        (else (tree-layout #:pict (atom->pict a)))))   ;; 3

(define my-tree
  '(or (if A1 (and A1 (not (if D1 (and A0 A0) (or A0 A0)))) (or A0 A0)) ()))


(define (save-pict the-pict name kind)
  (define bm (pict->bitmap the-pict))
  (send bm save-file name kind))


; P(f(a(), g(y)), x, g(y))
(define W3
  '(P (f (a ()) (g (y))) x (g (y))))

; P(h(a(), g(x)), x, g(x))
(define W4
  '(P (h (a ()) (g (x))) x (g (x))))

(define W5
  '(P _1 x (g (_0))))

; (naive-layered (draw my-node my-tree))
(naive-layered (draw my-node W3))
(naive-layered (draw my-node W4))
(naive-layered (draw my-node W5))

(save-pict (naive-layered (draw my-node W3)) "w1.png" 'png)
(save-pict (naive-layered (draw my-node W4)) "w2.png" 'png)
(save-pict (naive-layered (draw my-node W5)) "w3.png" 'png)
