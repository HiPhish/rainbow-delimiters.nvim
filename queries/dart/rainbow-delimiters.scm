(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(class_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(formal_parameter_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(optional_formal_parameters
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(list_literal
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(set_or_map_literal
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter @sentinel) @container
