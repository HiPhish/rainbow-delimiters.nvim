(anonymous_function
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(functioncall
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(bind
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesis
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(field
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(fieldname
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(forloop
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(indexing
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(object
  "{" @delimiter
  "}" @delimiter @sentinel) @container
