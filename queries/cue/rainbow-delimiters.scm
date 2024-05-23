(struct_lit
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(index_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(list_lit
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(label
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(attribute
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(dynamic
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(import_spec_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(interpolation
  "\\(" @delimiter
  ")" @delimiter @sentinel) @container
