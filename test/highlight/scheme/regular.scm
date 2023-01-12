(define (add x y)
  "A silly way to add two numbers recursively."
  (if (zero? y)
    x
    (add (add1 x)
         (sub1 y))))

(define-syntax foo
  (syntax-rules ()
    ((_ a ...)
     (printf "~a\n" (list a ...)))))

'(((a . b)))
'((((a b . c))))
