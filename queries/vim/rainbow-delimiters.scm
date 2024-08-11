;;; Note: The Vim grammar places all parentheses on the same level. This means
;;; an expression like (((3))) does not have three levels of nesting, but only
;;; one. All the parentheses and the integer literal are on the same level.
;;; This makes it impossible to apply alternating highlights.
;;;
;;; For some of the patterns it is possible to make a best effort by specifying
;;; multiple mutually exclusive variants.

(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(dictionnary  ;; this is no typo, "dictionary" is misspelled in the parser
  "{" @delimiter
  (dictionnary_entry
    ":" @delimiter)?
  "}" @delimiter @sentinel) @container

(call_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(unary_operation
  "(" @delimiter
  ")" @delimiter @sentinel) @container


;;; ---------------------------------------------------------------------------
(binary_operation
  left: ("(" @delimiter
         ")" @delimiter)
  right: ("(" @delimiter
          ")" @delimiter @sentinel)) @container

(binary_operation
  left: _ @_left
  (#not-eq? @_left "(")
  right: ("(" @delimiter
          ")" @delimiter @sentinel)) @container

(binary_operation
  left: ("(" @delimiter
         ")" @delimiter @sentinel)
  right: _ @_right
  (#not-eq? @_right "(")) @container


;;; ---------------------------------------------------------------------------
(ternary_expression
  condition: ("(" @delimiter
              ")" @delimiter)
  left: ("(" @delimiter
         ")" @delimiter)
  right: ("(" @delimiter
          ")" @delimiter @sentinel)) @container

(ternary_expression
  condition: _ @_condition
  (#not-eq? @_condition "(")
  left: ("(" @delimiter
         ")" @delimiter)
  right: ("(" @delimiter
          ")" @delimiter @sentinel)) @container

(ternary_expression
  condition: ("(" @delimiter
              ")" @delimiter)
  left: _ @_left
  (#not-eq? @_left "(")
  right: ("(" @delimiter
          ")" @delimiter @sentinel)) @container

(ternary_expression
  condition: ("(" @delimiter
              ")" @delimiter)
  left: ("(" @delimiter
          ")" @delimiter @sentinel)
  right: _ @_right
  (#not-eq? @_right "(")) @container

(ternary_expression
  condition: ("(" @delimiter
              ")" @delimiter @sentinel)
  left: _ @_left
  (#not-eq? @_left "(")
  right: _ @_right
  (#not-eq? @_right "(")) @container

(ternary_expression
  condition: _ @_condition
  (#not-eq? @_condition "(")
  left: ("(" @delimiter
              ")" @delimiter @sentinel)
  right: _ @_right
  (#not-eq? @_right "(")) @container

(ternary_expression
  condition: _ @_condition
  (#not-eq? @_condition "(")
  left: _ @_left
  (#not-eq? @_left "(")
  right: ("(" @delimiter
          ")" @delimiter @sentinel)) @container
