;;; This query includes React support as well.

;; String interpolation inside template strings
(template_substitution
  "${" @delimiter
  "}"  @delimiter @sentinel) @container

(object
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(statement_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(class_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(switch_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(formal_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_in_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(subscript_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(named_imports
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(export_clause
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(object_pattern
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array_pattern
  "[" @delimiter
  "]" @delimiter @sentinel) @container


;;; React.js support
(jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (identifier) @delimiter
              ">" @delimiter)
  close_tag: (jsx_closing_element
               "</" @delimiter
               name: (identifier) @delimiter
               ">" @delimiter @sentinel)) @container

(jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (member_expression) @delimiter
              ">" @delimiter)
  close_tag: (jsx_closing_element
              "</" @delimiter
               name: (member_expression) @delimiter
              ">" @delimiter @sentinel)) @container

(jsx_self_closing_element
  "<" @delimiter
  name: (identifier) @delimiter
  "/>" @delimiter @sentinel) @container

(jsx_self_closing_element
  "<" @delimiter
  name: (member_expression) @delimiter
  "/>" @delimiter @sentinel) @container

(jsx_expression
  "{" @delimiter
  "}" @delimiter @sentinel) @container
