;;; This query only covers Javascript without any React support.  It exists so
;;; that Typescript query can inherit it.

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

