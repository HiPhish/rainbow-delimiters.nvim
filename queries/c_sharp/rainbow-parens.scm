(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(argument_list
  "(" @opening
  ")" @closing) @container

(parameter_list
  "(" @opening
  ")" @closing) @container

(if_statement
  "(" @opening
  ")" @closing) @container

(for_each_statement
  "(" @opening
  ")" @closing) @container

(for_statement
  "(" @opening
  ")" @closing) @container

(while_statement
  "(" @opening
  ")" @closing) @container

(do_statement
  "(" @opening
  ")" @closing) @container

(tuple_type
  "(" @opening
  ")" @closing) @container

(tuple_expression
  "(" @opening
  ")" @closing) @container

(declaration_list
  "{" @opening
  "}" @closing) @container

(accessor_list
  "{" @opening
  "}" @closing) @container

(block
  "{" @opening
  "}" @closing) @container

(interpolation
  "{" @opening
  "}" @closing) @container

(anonymous_object_creation_expression
  "{" @opening
  "}" @closing) @container

(type_parameter_list
  "<" @opening
  ">" @closing) @container

(type_argument_list
  "<" @opening
  ">" @closing) @container

(initializer_expression
  "{" @opening
  "}" @closing) @container

(array_rank_specifier
  "[" @opening
  "]" @closing) @container

(bracketed_argument_list
  "[" @opening
  "]" @closing) @container
