(class_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(formal_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(dimensions
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array_access
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter @sentinel) @container
