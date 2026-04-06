(attrset_expression
  ("{" @delimiter)
  ("}" @delimiter)) @container

(rec_attrset_expression
  ("{" @delimiter)
  ("}" @delimiter)) @container

(formals
  ("{" @delimiter)
  ("}" @delimiter)) @container

(list_expression
  ("[" @delimiter)
  ("]" @delimiter)) @container

(parenthesized_expression
  ("(" @delimiter)
  (")" @delimiter)) @container

(interpolation
  ("${" @delimiter)
  ("}" @delimiter)) @container

(inherit_from
  "(" @delimiter
  ")" @delimiter) @container
