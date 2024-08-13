(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(hash
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(parenthesized_statements
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(block_parameters
  .
  "|" @delimiter
  "|" @delimiter @sentinel) @container
