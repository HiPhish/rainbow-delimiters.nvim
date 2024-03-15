(group
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(content
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(math
  "$" @delimiter
  "$" @delimiter @sentinel) @container
