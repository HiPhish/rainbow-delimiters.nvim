(call
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(subset
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(subset2
  "[[" @delimiter
  "]]" @delimiter @sentinel) @container

(if
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(brace_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container
