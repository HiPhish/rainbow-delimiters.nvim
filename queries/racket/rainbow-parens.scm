(list
  "(" @opening
  (dot)? @intermediate
  ")" @closing) @container

(list
  "[" @opening
  (dot)? @intermediate
  "]" @closing) @container

(list
  "{" @opening
  (dot)? @intermediate
  "}" @closing) @container

