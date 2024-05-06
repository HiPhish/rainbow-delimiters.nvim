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

(for
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(while
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(switch
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(function_definition
  (formal_parameters
    "(" @delimiter
    ")" @delimiter @sentinel)) @container

(brace_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container
