(arguments
  "(" @opening
  ")" @closing) @container

(parameters
  "(" @opening
  ")" @closing) @container

(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(table_constructor
  "{" @opening
  "}" @closing) @container

(bracket_index_expression
  "[" @opening
  "]" @closing) @container
