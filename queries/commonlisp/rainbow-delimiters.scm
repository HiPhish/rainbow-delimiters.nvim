(list_lit
  "(" @delimiter
   _*
   ")" @delimiter @sentinel) @container

(defun
  "(" @delimiter
   _*
   ")" @delimiter @sentinel) @container

(loop_macro
  "(" @delimiter
  ")" @delimiter @sentinel ) @container
