(expr
  "{" @opening
  "}" @closing) @container

(expr
  "[" @opening
  "]" @closing) @container

(expr
  "(" @opening
  ")" @closing) @container

(anonymous_function
  "(" @opening
  ")" @closing) @container

(bind
  "(" @opening
  ")" @closing) @container

(field
  "(" @opening
  ")" @closing) @container

(fieldname
  "[" @opening
  "]" @closing) @container
