; inherits: javascript

(interface_body
  "{" @delimiter
  "}" @delimiter) @container

(enum_body
  "{" @delimiter
  "}" @delimiter) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter) @container

(type_parameters
  "<" @delimiter
  ">" @delimiter) @container

(array_type
  "[" @delimiter
  "]" @delimiter) @container

(lookup_type
  "[" @delimiter
  "]" @delimiter) @container

(object_type
  "{" @delimiter
  "}" @delimiter) @container

(tuple_type
  "[" @delimiter
  "]" @delimiter) @container
