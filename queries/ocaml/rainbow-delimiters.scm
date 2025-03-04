(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(array_get_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; doesn't work on annotated types?
; (parameter
;   "(" @delimiter
;   ")" @delimiter @sentinel) @container

(local_open_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(constructed_type
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(package_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(record_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(record_expression
  "{" @delimiter
  "}" @delimiter @sentinel) @container
