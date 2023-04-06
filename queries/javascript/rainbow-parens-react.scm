;;; String interpolation inside template strings
(template_substitution
  "${" @opening
  "}"  @closing) @container

(object
  "{" @opening
  "}" @closing) @container

(statement_block
  "{" @opening
  "}" @closing) @container

(class_body
  "{" @opening
  "}" @closing) @container

(arguments
  "(" @opening
  ")" @closing) @container

(formal_parameters
  "(" @opening
  ")" @closing) @container

(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(subscript_expression
  "[" @opening
  "]" @closing) @container


;;; React.js support
(jsx_element
  (jsx_opening_element ["<" ">"] @opening)
  (jsx_closing_element ["<" "/" ">"] @closing)) @container

(jsx_self_closing_element
  "<" @opening
  ["/" ">"] @closing) @container
