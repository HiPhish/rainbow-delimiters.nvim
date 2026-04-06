(anonymous_capturing_group
  "(" @delimiter
  ")" @delimiter) @container

;;; The inversion `^` should be an opening node as well
(character_class
  "[" @delimiter
  "]" @delimiter) @container

(count_quantifier
  "{" @delimiter
  "}" @delimiter) @container

;;; We should probably include the character after `?` like `=` as well
(lookaround_assertion
  "(?" @delimiter
  ")" @delimiter) @container
