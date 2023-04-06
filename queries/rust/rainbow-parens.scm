(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(declaration_list
  "{" @opening
  "}" @closing) @container

(field_declaration_list
  "{" @opening
  "}" @closing) @container

(ordered_field_declaration_list
  "(" @opening
  ")" @closing) @container

(enum_variant_list
  "{" @opening
  "}" @closing) @container

(use_list
  "{" @opening
  "}" @closing) @container

(field_initializer_list
  "{" @opening
  "}" @closing) @container

(parameters
  "(" @opening
  ")" @closing) @container

(arguments
  "(" @opening
  ")" @closing) @container

(block
  "{" @opening
  "}" @closing) @container

(match_block
  "{" @opening
  "}" @closing) @container

(tuple_expression
  "(" @opening
  ")" @closing) @container

(tuple_type
  "(" @opening
  ")" @closing) @container

(token_tree
  "{" @opening
  "}" @closing) @container

(token_tree
  "(" @opening
  ")" @closing) @container

(token_tree
  "[" @opening
  "]" @closing) @container

(token_tree_pattern
  "(" @opening
  ")" @closing) @container

(token_repetition_pattern
  "(" @opening
  ")" @closing) @container

(attribute_item
  "[" @opening
  "]" @closing) @container

(inner_attribute_item
  "[" @opening
  "]" @closing) @container

(type_arguments
  "<" @opening
  ">" @closing) @container

(type_parameters
  "<" @opening
  ">" @closing) @container

(closure_parameters
  "|" @opening
  "|" @closing) @container

(array_expression
  "[" @opening
  "]" @closing) @container

(index_expression
  "[" @opening
  "]" @closing) @container

(tuple_struct_pattern
  "(" @opening
  ")" @closing) @container

(tuple_pattern
  "(" @opening
  ")" @closing) @container

(struct_pattern
  "{" @opening
  "}" @closing) @container

(slice_pattern
  "[" @opening
  "]" @closing) @container

(macro_definition
  "{" @opening
  "}" @closing) @container
