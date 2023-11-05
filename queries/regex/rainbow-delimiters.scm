(anonymous_capturing_group
  "(" @delimiter
  ")" @delimiter @sentinel) @container

;;; The inversion `^` should be an opening node as well
(character_class
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(count_quantifier
  "{" @delimiter
  "}" @delimiter @sentinel) @container

;;; We should probably include the character after `?` like `=` as well
(lookaround_assertion
  "(?" @delimiter
  ")" @delimiter @sentinel) @container
