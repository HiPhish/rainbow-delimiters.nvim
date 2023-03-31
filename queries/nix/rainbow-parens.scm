(attrset_expression
  ("{" @opening)
  ("}" @closing)) @container

(formals
  ("{" @opening)
  ("}" @closing)) @container

(list_expression
  ("[" @opening)
  ("]" @closing)) @container

(parenthesized_expression
  ("(" @opening)
  (")" @closing)) @container

(interpolation
  ("${" @opening)
  ("}" @closing)) @container
