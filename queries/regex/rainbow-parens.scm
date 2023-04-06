(anonymous_capturing_group
  "(" @opening
  ")" @closing) @container

;;; The inversion `^` should be an opening node as well
(character_class
  "[" @opening
  "]" @closing) @container

(count_quantifier
  "{" @opening
  "}" @closing) @container

;;; We should probably include the character after `?` like `=` as well
(lookahead_assertion
  "(?" @opening
  ")" @closing) @container
