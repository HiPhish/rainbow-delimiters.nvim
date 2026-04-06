(parameters
  "(" @delimiter
  ")" @delimiter) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(polymorphic_parameters
  "(" @delimiter
  ")" @delimiter) @container

(polymorphic_type
  "(" @delimiter
  ")" @delimiter) @container

(attribute
  "(" @delimiter
  ")" @delimiter) @container

(call_expression
  "(" @delimiter
  ")" @delimiter) @container

(index_expression
  "[" @delimiter
  "]" @delimiter) @container

(slice_expression
  "[" @delimiter
  "]" @delimiter) @container

(block
  "{" @delimiter
  "}" @delimiter) @container

(switch_statement
  "{" @delimiter
  "}" @delimiter) @container

(array_type
  "[" @delimiter
  "]" @delimiter) @container

(struct
 ("(" @delimiter
  ")" @delimiter)?
 ("[" @delimiter
  "]" @delimiter)?
 ("{" @delimiter
  "}" @delimiter)
  ) @container

(map_type
  "[" @delimiter
  "]" @delimiter) @container

(map
  "[" @delimiter
  "]" @delimiter
  "{" @delimiter
  "}" @delimiter) @container

(matrix_type
  "[" @delimiter
  "]" @delimiter) @container

(matrix
  "[" @delimiter
  "]" @delimiter
  "{" @delimiter
  "}" @delimiter) @container

(bit_set_type
  "[" @delimiter
  "]" @delimiter) @container

(bit_set
  "[" @delimiter
  "]" @delimiter
  "{" @delimiter
  "}" @delimiter) @container

(struct_declaration
  "{" @delimiter
  "}" @delimiter) @container

(enum_declaration
  "{" @delimiter
  "}" @delimiter) @container

(union_declaration
  "{" @delimiter
  "}" @delimiter) @container

(bit_field_declaration
  "{" @delimiter
  "}" @delimiter) @container
