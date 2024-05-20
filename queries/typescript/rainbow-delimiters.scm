; inherits: javascript

(interface_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(enum_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(type_parameters
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(lookup_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(object_type
  "{" @delimiter
  "}" @delimiter @sentinel) @container
