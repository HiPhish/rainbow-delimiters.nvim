;;; Angular HTML

;; HTML elements
(element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter @sentinel)) @container

(element
  (self_closing_tag
    "<" @delimiter
    (tag_name) @delimiter
    "/>" @delimiter @sentinel)) @container

;; Angular interpolation {{ }}
(interpolation
  "{{" @delimiter
  "}}" @delimiter @sentinel) @container

;; @if condition parentheses
(if_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(statement_block
  "{" @delimiter 
  "}" @delimiter @sentinel) @container
