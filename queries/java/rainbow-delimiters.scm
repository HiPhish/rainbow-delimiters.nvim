(class_body
  "{" @opening
  "}" @closing) @container

(block
  "{" @opening
  "}" @closing) @container

(formal_parameters
  "(" @opening
  ")" @closing) @container

(argument_list
  "(" @opening
  ")" @closing) @container

(dimensions
  "[" @opening
  "]" @closing) @container

(array_access
  "[" @opening
  "]" @closing) @container

(type_arguments
  "<" @opening
  ">" @closing) @container
