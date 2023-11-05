;;; Note: The Vim grammar places all parentheses on the same level. This means
;;; an expression like (((3))) does not have three levels of nesting, but only
;;; one. All the parentheses and the integer literal are on the same level.
;;; This makes it impossible to apply alternating highlights.
(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(dictionnary  ;; this is no typo, "dictionary" is misspelled in the parser
  "{" @delimiter
  (dictionnary_entry
    ":" @delimiter)
  "}" @delimiter @sentinel) @container

(call_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(unary_operation
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(binary_operation
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(ternary_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container
