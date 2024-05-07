(defun add (x y)
  "A silly way to add two numbers recursively."
  (if (zerop y)
    x
    (add (incf x)
         (decf y))))

(defmacro foo (a &rest rest)
  `(format t "~A~%" (list ,a ,@rest)))

;;; The LOOP macro has its own node type
(loop repeat 3
      do (print "Hello world"))

'(((a . b)))
'((((a b . c))))
