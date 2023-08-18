(anonymous_function
  "(" @opening
  ")" @closing) @container

(functioncall
  "(" @opening
  ")" @closing) @container

(bind
  "(" @opening
  ")" @closing) @container

(parenthesis
  "(" @opening
  ")" @closing) @container

(field
  "(" @opening
  ")" @closing) @container

(fieldname
  "[" @opening
  "]" @closing) @container

(array
  "[" @opening
  "]" @closing) @container

(forloop
  "[" @opening
  "]" @closing) @container

(indexing
  "[" @opening
  "]" @closing) @container

(object
  "{" @opening
  "}" @closing) @container
