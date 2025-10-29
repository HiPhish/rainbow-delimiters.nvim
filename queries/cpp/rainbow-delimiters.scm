;;; NOTE: The C and C++ grammar have diverged, so I cannot include the C query.

(parameter_list
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(argument_list
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(condition_clause
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(decltype
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(static_assert_declaration
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(sizeof_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_declarator
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(compound_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(for_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_range_loop
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(cast_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(enumerator_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(initializer_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array_declarator
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(subscript_argument_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(lambda_capture_specifier
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(new_declarator
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(structured_binding_declarator
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

(template_argument_list
  "<" @delimiter
  ">" @delimiter @sentinel) @container
