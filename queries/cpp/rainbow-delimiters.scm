;;; NOTE: The C and C++ grammar have diverged, so I cannot include the C query.

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

(subscript_argument_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(field_declaration_list
   "{" @delimiter
   "}" @delimiter @sentinel) @container

(declaration_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(template_parameter_list
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(initializer_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(template_argument_list
  "<" @delimiter
  ">" @delimiter @sentinel) @container
