(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(declaration_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(field_declaration_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(ordered_field_declaration_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(enum_variant_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(use_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(field_initializer_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(match_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(tuple_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(token_tree
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(token_tree
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(token_tree
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(token_tree_pattern
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(token_repetition_pattern
  "$" @delimiter
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(token_repetition
  "$" @delimiter
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(attribute_item
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(inner_attribute_item
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(type_parameters
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(closure_parameters
  "|" @delimiter
  "|" @delimiter @sentinel) @container

(array_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(index_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(tuple_struct_pattern
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple_pattern
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(struct_pattern
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(slice_pattern
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(macro_definition
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(visibility_modifier
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(bracketed_type
  "<" @delimiter
  ">" @delimiter @sentinel) @container
