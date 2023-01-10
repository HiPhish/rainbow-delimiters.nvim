(list
  [(("(" @opening)
    (dot)? @intermediate
    (")" @closing))
   (("[" @opening)
    (dot)? @intermediate
    ("]" @closing))
   (("{" @opening)
    (dot)? @intermediate
    ("}" @closing))]) @container
