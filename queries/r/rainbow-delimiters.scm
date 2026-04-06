(arguments
  "(" @delimiter
  ")" @delimiter) @container

(arguments
  "[" @delimiter
  "]" @delimiter) @container

(arguments
  "[[" @delimiter
  "]]" @delimiter) @container

(if_statement
  "(" @delimiter
  ")" @delimiter) @container

(for_statement
  "(" @delimiter
  ")" @delimiter) @container

(while_statement
  "(" @delimiter
  ")" @delimiter) @container

(function_definition
  (parameters
    "(" @delimiter
    ")" @delimiter)) @container

(braced_expression
  "{" @delimiter
  "}" @delimiter) @container
