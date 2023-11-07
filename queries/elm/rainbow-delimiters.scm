(exposing_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(exposed_operator
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(exposed_union_constructors
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(_
  "(" @delimiter
  .
  (type_expression)
  .
  ")" @delimiter @sentinel
) @container

(_
"(" @delimiter
  .
  [(pattern) (union_pattern)]
  .
")" @delimiter @sentinel
)  @container

(record_expr
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(record_type
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(record_pattern
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(tuple_expr
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple_pattern
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expr
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list_expr
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(list_pattern
  "[" @delimiter
  "]" @delimiter @sentinel) @container
