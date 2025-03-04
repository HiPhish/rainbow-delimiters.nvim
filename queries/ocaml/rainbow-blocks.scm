; It shouldn't work but it works, I don't know why
(let_expression
  (value_definition
  "let" @delimiter
  ("rec" @delimiter)?
  )
  "in" @delimiter @sentinel) @container

(match_expression
  "match" @delimiter
  "with" @delimiter
  ("|"  @delimiter (match_case))+
   ) @container

; I can't get it to collapse else if into one
(if_expression
  "if" @delimiter
  (then_clause "then" @delimiter)
  (else_clause "else" @delimiter)*
  ) @container

(for_expression
  "for" @delimiter
  "to" @delimiter
  (do_clause
  "do" @delimiter
  "done" @delimiter)) @container

(while_expression
  "while" @delimiter
  (do_clause
  "do" @delimiter
  "done" @delimiter)) @container

;;; Copied over from rainbow-delimiters

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
