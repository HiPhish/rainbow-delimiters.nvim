(exposing_list
  "(" @delimiter
  ")" @delimiter) @container

(exposed_operator
  "(" @delimiter
  ")" @delimiter) @container

(exposed_union_constructors
  "(" @delimiter
  ")" @delimiter) @container

;;; Broken by design, see https://github.com/elm-tooling/tree-sitter-elm/issues/159
(_
  "(" @delimiter
  .
  (type_expression)
  .
  ")" @delimiter
) @container

;;; Broken by design, see https://github.com/elm-tooling/tree-sitter-elm/issues/159
(_
"(" @delimiter
  .
  [(pattern) (union_pattern)]
  .
")" @delimiter
)  @container

(record_expr
  "{" @delimiter
  "}" @delimiter) @container

(record_type
  "{" @delimiter
  "}" @delimiter) @container

(record_pattern
  "{" @delimiter
  "}" @delimiter) @container

(tuple_expr
  "(" @delimiter
  ")" @delimiter) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter) @container

(tuple_pattern
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expr
  "(" @delimiter
  ")" @delimiter) @container

(list_expr
  "[" @delimiter
  "]" @delimiter) @container

(list_pattern
  "[" @delimiter
  "]" @delimiter) @container
