;;; This query includes React support as well.

;; String interpolation inside template strings
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

(named_imports
  "{" @opening
  "}" @closing) @container

(export_clause
  "{" @opening
  "}" @closing) @container

(object_pattern
  "{" @opening
  "}" @closing) @container

(array
  "[" @opening
  "]" @closing) @container


;;; React.js support
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
