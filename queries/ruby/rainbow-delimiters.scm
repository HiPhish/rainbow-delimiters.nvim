(interpolation
  "#{" @delimiter
  "}" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(hash
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(element_reference
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(method_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_statements
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(block_parameters
  .
  "|" @delimiter
  "|" @delimiter @sentinel) @container
