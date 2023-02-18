(defn fn-name "docs" [a0 a1 & xz]
  [
   "some _text_ with parens #() #{} {} [] (#())"
   '(#(identity ""))
   [[[], [[]]], #(:k {}), #{{}, ""}, '((())), `({})]
   ]
  )

(fn-name 1 2 3 4)
