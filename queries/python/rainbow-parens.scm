(list
  (("[" @opening)
   ("]" @closing))) @container

(dictionary
  (("{" @opening)
   ("}" @closing))) @container

(set
  (("{" @opening)
   ("}" @closing))) @container

(tuple
  (("(" @opening)
   (")" @closing))) @container

(argument_list
  (("(" @opening)
   (")" @closing))) @container

(parenthesized_expression
  (("(" @opening)
   (")" @closing))) @container
