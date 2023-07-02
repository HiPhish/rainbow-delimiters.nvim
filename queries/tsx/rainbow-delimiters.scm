; inherits: typescript

(jsx_element
  open_tag: (jsx_opening_element
              name: (identifier) @opening)
  close_tag: (jsx_closing_element
               name: (identifier) @closing)) @container

(jsx_self_closing_element
  name: (identifier) @opening
  "/" @closing) @container

(jsx_expression
  "{" @opening
  "}" @closing) @container
