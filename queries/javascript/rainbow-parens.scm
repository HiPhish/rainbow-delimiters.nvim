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
