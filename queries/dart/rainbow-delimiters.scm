(block
  "{" @delimiter
  "}" @delimiter) @container

(arguments
  "(" @delimiter
  ")" @delimiter) @container

(class_body
  "{" @delimiter
  "}" @delimiter) @container

(formal_parameter_list
  "(" @delimiter
  ")" @delimiter) @container

(optional_formal_parameters
  "{" @delimiter
  "}" @delimiter) @container

(list_literal
  "[" @delimiter
  "]" @delimiter) @container

(set_or_map_literal
  "{" @delimiter
  "}" @delimiter) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter) @container
