(parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(polymorphic_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(polymorphic_type
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(attribute
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(call_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(index_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(slice_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(switch_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(struct
 ("(" @delimiter
  ")" @delimiter)?
 ("[" @delimiter
  "]" @delimiter)?
 ("{" @delimiter
  "}" @delimiter @sentinel)
  ) @container

(map_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(map
  "[" @delimiter
  "]" @delimiter
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(matrix_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(matrix
  "[" @delimiter
  "]" @delimiter
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(bit_set_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(bit_set
  "[" @delimiter
  "]" @delimiter
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(struct_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(enum_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(union_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(bit_field_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container
