;;; Note: The Vim grammar places all parentheses on the same level. This means
;;; an expression like (((3))) does not have three levels of nesting, but only
;;; one. All the parentheses and the integer literal are on the same level.
;;; This makes it impossible to apply alternating highlights.
(list
  "[" @opening
  "]" @closing) @container

(dictionnary  ;; this is no typo, "dictionary" is misspelled in the parser
  "{" @opening
  (dictionnary_entry
    ":" @intermediate)
  "}" @closing) @container

(call_expression
  "(" @opening
  ")" @closing) @container

(unary_operation
  "(" @opening
  ")" @closing) @container

(binary_operation
  "(" @opening
  ")" @closing) @container

(ternary_expression
  "(" @opening
  ")" @closing) @container
