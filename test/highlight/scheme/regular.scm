(define (add x y)
  "A silly way to add two numbers recursively."
  (if (zero? y)
    x
    (add (add1 x)
         (sub1 y))))

;; R6RS allows square brackets as well
(define [mult x y]
  "A silly way of multiplying to numbers recursively"
  (if [= 1 y]
    x
    (add (add x x)
         (sub1 y))))

(define-syntax foo
  (syntax-rules ()
    ((_ a ...)
     (printf "~a\n" (list a ...)))))

'(((a . b)))
'((((a b . c))))
