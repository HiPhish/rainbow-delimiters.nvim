(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(declaration_list
  "{" @opening
  "}" @closing) @container

(block
  "{" @opening
  "}" @closing) @container

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
