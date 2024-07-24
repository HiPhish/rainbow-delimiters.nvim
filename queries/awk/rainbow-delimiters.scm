(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(grouping
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(array_ref
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(func_call
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(if_statement
  "if"
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(while_statement
  "while"
  "(" @delimiter
  ")" @delimiter @sentinel) @container

;; This messes up the highlighting of the sibling block
; (do_while_statement
;   "(" @delimiter
;   ")" @delimiter @sentinel) @container

(for_statement
  "for"
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_in_statement
  "for"
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(switch_statement
  "switch"
  "(" @delimiter
  ")" @delimiter
  (switch_body
    "{" @delimiter
    "}" @delimiter @sentinel)) @container
