(interpolation
  "#{" @delimiter
  "}" @delimiter) @container

(block
  "{" @delimiter
  "}" @delimiter) @container

(hash
  "{" @delimiter
  "}" @delimiter) @container

(array
  "[" @delimiter
  "]" @delimiter) @container

(element_reference
  "[" @delimiter
  "]" @delimiter) @container

(argument_list
  "(" @delimiter
  ")" @delimiter) @container

(method_parameters
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_statements
  "(" @delimiter
  ")" @delimiter) @container

(block_parameters
  .
  "|" @delimiter
  "|" @delimiter) @container
