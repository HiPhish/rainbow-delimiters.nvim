;;; String interpolation inside template strings
(template_substitution
  (("${" @opening)
   ("}"  @closing))) @container

(object
  (("{" @opening)
   ("}" @closing))) @container

(statement_block
  (("{" @opening)
   ("}" @closing))) @container

(class_body
  (("{" @opening)
   ("}" @closing))) @container

(arguments
  (("(" @opening)
   (")" @closing))) @container

(formal_parameters
  (("(" @opening)
   (")" @closing))) @container

(parenthesized_expression
  ("(" @opening
   ")" @closing)) @container

(subscript_expression
  ("[" @opening
   "]" @closing)) @container


;;; React.js support
(jsx_element
  open_tag: (jsx_opening_element) @opening
  close_tag: (jsx_closing_element) @closing) @container
