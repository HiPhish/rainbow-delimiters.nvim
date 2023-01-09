(parameter_list
   (("(" @opening)
    (")" @closing))) @container

(argument_list
   (("(" @opening)
    (")" @closing))) @container

(parenthesized_expression
  (("(" @opening)
   (")" @closing))) @container

(compound_statement
  (("{" @opening)
   ("}" @closing))) @container

(initializer_list
  (("{" @opening)
   ("}" @closing))) @container

(subscript_expression
  (("[" @opening)
   ("]" @closing))) @container
