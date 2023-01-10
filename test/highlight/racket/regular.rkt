#lang racket

(define [add x y]
  "A silly way to add two numbers recursively."
  (if (zero? y)
    x
    (add (add1 x)
         (sub1 x))))

(define-syntax foo
  (syntax-rules ()
    ((_ a ...)
     (printf "~a\n" (list a ...)))))

{+ 2 {+ 3 {+ 4 5}}}

'(((a . b)))
'((((a b . c))))

'[[[a . b]]]
'[[[a b . c]]]

'{{{a . b}}}
'
'([{a . b}])
'([{a b . c}])

;;; Vector literals
#(#(#(a)))
#[#[#[a]]]
#{#{#{a}}}


;;; Inexact number vector literals
#fl(#fl(#fl(a)))
#fl[#fl[#fl[a]]]
#fl{#fl{#fl{a}}}

#Fl(#Fl(#Fl(a)))
#Fl[#Fl[#Fl[a]]]
#Fl{#Fl{#Fl{a}}}


;;; Fixnum vector literals
#fx(#fx(#fx(a)))
#fx[#fx[#fx[a]]]
#fx{#fx{#fx{a}}}

#Fx(#Fx(#Fx(a)))
#Fx[#Fx[#Fx[a]]]
#Fx{#Fx{#Fx{a}}}


;;; Structures
(struct prefab-point (x y) #:prefab)
'#s(prefab-point 1 2)
