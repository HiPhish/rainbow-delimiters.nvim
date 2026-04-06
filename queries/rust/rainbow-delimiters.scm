(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(declaration_list
  "{" @delimiter
  "}" @delimiter) @container

(field_declaration_list
  "{" @delimiter
  "}" @delimiter) @container

(ordered_field_declaration_list
  "(" @delimiter
  ")" @delimiter) @container

(enum_variant_list
  "{" @delimiter
  "}" @delimiter) @container

(use_list
  "{" @delimiter
  "}" @delimiter) @container

(field_initializer_list
  "{" @delimiter
  "}" @delimiter) @container

(parameters
  "(" @delimiter
  ")" @delimiter) @container

(arguments
  "(" @delimiter
  ")" @delimiter) @container

(block
  "{" @delimiter
  "}" @delimiter) @container

(match_block
  "{" @delimiter
  "}" @delimiter) @container

(tuple_expression
  "(" @delimiter
  ")" @delimiter) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter) @container

(token_tree
  "{" @delimiter
  "}" @delimiter) @container

(token_tree
  "(" @delimiter
  ")" @delimiter) @container

(token_tree
  "[" @delimiter
  "]" @delimiter) @container

(token_tree_pattern
  "(" @delimiter
  ")" @delimiter) @container

(token_repetition_pattern
  "$" @delimiter
  "(" @delimiter
  ")" @delimiter) @container

(token_repetition
  "$" @delimiter
  "(" @delimiter
  ")" @delimiter) @container

(attribute_item
  "[" @delimiter
  "]" @delimiter) @container

(inner_attribute_item
  "[" @delimiter
  "]" @delimiter) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter) @container

(type_parameters
  "<" @delimiter
  ">" @delimiter) @container

(closure_parameters
  "|" @delimiter
  (_)?
  "|" @delimiter) @container

(array_expression
  "[" @delimiter
  "]" @delimiter) @container

(array_type
  "[" @delimiter
  "]" @delimiter) @container

(index_expression
  "[" @delimiter
  "]" @delimiter) @container

(tuple_struct_pattern
  "(" @delimiter
  ")" @delimiter) @container

(tuple_pattern
  "(" @delimiter
  ")" @delimiter) @container

(struct_pattern
  "{" @delimiter
  "}" @delimiter) @container

(slice_pattern
  "[" @delimiter
  "]" @delimiter) @container

(macro_definition
  "{" @delimiter
  "}" @delimiter) @container

(visibility_modifier
  "(" @delimiter
  ")" @delimiter) @container

(bracketed_type
  "<" @delimiter
  ">" @delimiter) @container
