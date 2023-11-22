(function_type
  "(" @delimiter
  ")" @delimiter @sentinel
) @container

(parenthesized_type
  "(" @delimiter
  ")" @delimiter @sentinel
) @container

;;; I wanted to use something like
; (union_type
;   "|" @delimiter @sentinel
; ) @container
;;; too, but it doesn't fully work with the current parser

(array_type
  "[" @delimiter
  "]" @delimiter @sentinel
) @container

(table_type
  "<" @delimiter
  ">" @delimiter @sentinel
) @container

(table_literal_type
  "{" @delimiter
  "}" @delimiter @sentinel
) @container

(_
  "[" @delimiter
  .
  field: (_)
  .
  "]" @delimiter @sentinel
) @container

