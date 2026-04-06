;;; This query includes React support as well.

;; String interpolation inside template strings
(template_substitution
  "${" @delimiter
  "}"  @delimiter) @container

(object
  "{" @delimiter
  "}" @delimiter) @container

(computed_property_name
  "[" @delimiter
  "]" @delimiter) @container

(statement_block
  "{" @delimiter
  "}" @delimiter) @container

(class_body
  "{" @delimiter
  "}" @delimiter) @container

(switch_body
  "{" @delimiter
  "}" @delimiter) @container

(arguments
  "(" @delimiter
  ")" @delimiter) @container

(formal_parameters
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(for_statement
  "(" @delimiter
  ")" @delimiter) @container

(for_in_statement
  "(" @delimiter
  ")" @delimiter) @container

(subscript_expression
  "[" @delimiter
  "]" @delimiter) @container

(named_imports
  "{" @delimiter
  "}" @delimiter) @container

(export_clause
  "{" @delimiter
  "}" @delimiter) @container

(object_pattern
  "{" @delimiter
  "}" @delimiter) @container

(array
  "[" @delimiter
  "]" @delimiter) @container

(array_pattern
  "[" @delimiter
  "]" @delimiter) @container


;;; React.js support
(jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (identifier) @delimiter
              ">" @delimiter)
  close_tag: (jsx_closing_element
               "</" @delimiter
               name: (identifier) @delimiter
               ">" @delimiter)) @container

(jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (member_expression) @delimiter
              ">" @delimiter)
  close_tag: (jsx_closing_element
              "</" @delimiter
               name: (member_expression) @delimiter
              ">" @delimiter)) @container

(jsx_self_closing_element
  "<" @delimiter
  name: (identifier) @delimiter
  "/>" @delimiter) @container

(jsx_self_closing_element
  "<" @delimiter
  name: (member_expression) @delimiter
  "/>" @delimiter) @container

(jsx_expression
  "{" @delimiter
  "}" @delimiter) @container
