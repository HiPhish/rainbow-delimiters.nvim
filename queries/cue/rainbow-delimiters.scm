(struct_lit
  "{" @delimiter
  "}" @delimiter) @container

(index_expression
  "[" @delimiter
  "]" @delimiter) @container

(list_lit
  "[" @delimiter
  "]" @delimiter) @container

(label
  "[" @delimiter
  "]" @delimiter) @container

(arguments
  "(" @delimiter
  ")" @delimiter) @container

(attribute
  "(" @delimiter
  ")" @delimiter) @container

(dynamic
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(import_spec_list
  "(" @delimiter
  ")" @delimiter) @container

(interpolation
  "\\(" @delimiter
  ")" @delimiter) @container
