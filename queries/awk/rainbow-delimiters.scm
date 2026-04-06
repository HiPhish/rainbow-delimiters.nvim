(block
  "{" @delimiter
  "}" @delimiter) @container

(grouping
  "(" @delimiter
  ")" @delimiter) @container

(array_ref
  "[" @delimiter
  "]" @delimiter) @container

(func_call
  "(" @delimiter
  ")" @delimiter) @container

(if_statement
  "if"
  "(" @delimiter
  ")" @delimiter) @container

(while_statement
  "while"
  "(" @delimiter
  ")" @delimiter) @container

;; This messes up the highlighting of the sibling block
; (do_while_statement
;   "(" @delimiter
;   ")" @delimiter) @container

(for_statement
  "for"
  "(" @delimiter
  ")" @delimiter) @container

(for_in_statement
  "for"
  "(" @delimiter
  ")" @delimiter) @container

(switch_statement
  "switch"
  "(" @delimiter
  ")" @delimiter
  (switch_body
    "{" @delimiter
    "}" @delimiter)) @container
