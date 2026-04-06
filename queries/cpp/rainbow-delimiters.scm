;;; NOTE: The C and C++ grammar have diverged, so I cannot include the C query.

(parameter_list
   "(" @delimiter
   ")" @delimiter) @container

(argument_list
   "(" @delimiter
   ")" @delimiter) @container

(condition_clause
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(decltype
  "(" @delimiter
  ")" @delimiter) @container

(static_assert_declaration
  "(" @delimiter
  ")" @delimiter) @container

(sizeof_expression
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_declarator
  "(" @delimiter
  ")" @delimiter) @container

(compound_statement
  "{" @delimiter
  "}" @delimiter) @container

(for_statement
  "(" @delimiter
  ")" @delimiter) @container

(for_range_loop
  "(" @delimiter
  ")" @delimiter) @container

(cast_expression
  "(" @delimiter
  ")" @delimiter) @container

(enumerator_list
  "{" @delimiter
  "}" @delimiter) @container

(initializer_list
  "{" @delimiter
  "}" @delimiter) @container

(array_declarator
  "[" @delimiter
  "]" @delimiter) @container

(subscript_argument_list
  "[" @delimiter
  "]" @delimiter) @container

(lambda_capture_specifier
  "[" @delimiter
  "]" @delimiter) @container

(new_declarator
  "[" @delimiter
  "]" @delimiter) @container

(structured_binding_declarator
  "[" @delimiter
  "]" @delimiter) @container

(field_declaration_list
   "{" @delimiter
   "}" @delimiter) @container

(declaration_list
  "{" @delimiter
  "}" @delimiter) @container

(template_parameter_list
  "<" @delimiter
  ">" @delimiter) @container

(template_argument_list
  "<" @delimiter
  ">" @delimiter) @container
