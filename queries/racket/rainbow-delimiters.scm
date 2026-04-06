(list
  "(" @delimiter
  (dot)? @delimiter
  ")" @delimiter) @container

(list
  "[" @delimiter
  (dot)? @delimiter
  "]" @delimiter) @container

(list
  "{" @delimiter
  (dot)? @delimiter
  "}" @delimiter) @container
