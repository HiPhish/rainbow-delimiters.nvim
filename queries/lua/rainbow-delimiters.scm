(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(table_constructor
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(bracket_index_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(field
  "[" @delimiter
  "]" @delimiter @sentinel) @container
