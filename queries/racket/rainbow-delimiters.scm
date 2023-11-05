(list
  "(" @delimiter
  (dot)? @delimiter
  ")" @delimiter @sentinel) @container

(list
  "[" @delimiter
  (dot)? @delimiter
  "]" @delimiter @sentinel) @container

(list
  "{" @delimiter
  (dot)? @delimiter
  "}" @delimiter @sentinel) @container
