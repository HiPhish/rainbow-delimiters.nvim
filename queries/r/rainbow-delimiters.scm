(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(arguments
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(arguments
  "[[" @delimiter
  "]]" @delimiter @sentinel) @container

(if_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(while_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(function_definition
  (parameters
    "(" @delimiter
    ")" @delimiter @sentinel)) @container

(braced_expression
  "{" @delimiter
  "}" @delimiter @sentinel) @container
