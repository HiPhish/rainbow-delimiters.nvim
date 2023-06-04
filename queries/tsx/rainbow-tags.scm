; inherits: typescript

(jsx_element
  open_tag: (jsx_opening_element) @opening
  close_tag: (jsx_closing_element) @closing) @container

(jsx_expression
  "{" @opening
  "}" @closing) @container
