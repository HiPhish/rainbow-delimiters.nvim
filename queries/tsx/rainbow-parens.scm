; inherits: typescript

(jsx_element
  (jsx_opening_element ["<" ">"] @opening)
  (jsx_closing_element ["<" "/" ">"] @closing)) @container

(jsx_self_closing_element
  "<" @opening
  ["/" ">"] @closing) @container
