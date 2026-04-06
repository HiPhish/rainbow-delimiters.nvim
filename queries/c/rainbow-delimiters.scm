(parameter_list
  "(" @delimiter
  ")" @delimiter) @container

(argument_list
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(compound_statement
  "{" @delimiter
  "}" @delimiter) @container

(initializer_list
  "{" @delimiter
  "}" @delimiter) @container

; This highlights the nested levels in an array differently
; although they are the same level in terms of the nesting
; of delimiters
(subscript_expression
  "[" @delimiter
  "]" @delimiter) @container

(field_declaration_list
  "{" @delimiter
  "}" @delimiter) @container

(array_declarator
  "[" @delimiter
  "]" @delimiter) @container

(sizeof_expression
  "(" @delimiter
  ")" @delimiter) @container

(for_statement
  "(" @delimiter
  ")" @delimiter) @container

; Comment out the following to not highlight type casts
(cast_expression
  "(" @delimiter
  ")" @delimiter) @container

(enumerator_list
  "{" @delimiter
  "}" @delimiter) @container

(macro_type_specifier
  "(" @delimiter
  ")" @delimiter) @container

(preproc_params
  "(" @delimiter
  ")" @delimiter) @container

(compound_literal_expression
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_declarator
  "(" @delimiter
  ")" @delimiter) @container
