(parameter_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(compound_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(initializer_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

; This highlights the nested levels in an array differently
; although they are the same level in terms of the nesting
; of delimiters
(subscript_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(field_declaration_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array_declarator
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(sizeof_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; Comment out the following to not highlight type casts
(cast_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(enumerator_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(macro_type_specifier
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(preproc_params
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(compound_literal_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_declarator
  "(" @delimiter
  ")" @delimiter @sentinel) @container
