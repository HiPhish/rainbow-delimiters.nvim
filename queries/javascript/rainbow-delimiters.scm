;;; This query only covers Javascript without any React support.  It exists so
;;; that Typescript query can inherit it.

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

