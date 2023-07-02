(block
  "{" @opening
  "}" @closing) @container

(arguments
  "(" @opening
  ")" @closing) @container

(class_body
  "{" @opening
  "}" @closing) @container

(formal_parameter_list
  "(" @opening
  ")" @closing) @container

(optional_formal_parameters
  "{" @opening
  "}" @closing) @container

(list_literal
  "[" @opening
  "]" @closing) @container

(set_or_map_literal
  "{" @opening
  "}" @closing) @container

(type_arguments
  "<" @opening
  ">" @closing) @container
