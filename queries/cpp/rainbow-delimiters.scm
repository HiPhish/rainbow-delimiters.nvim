;;; NOTE: The C and C++ grammar have diverged, so I cannot include the C query.

(parameter_list
   "(" @opening
   ")" @closing) @container

(argument_list
   "(" @opening
   ")" @closing) @container

(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(compound_statement
  "{" @opening
  "}" @closing) @container

(initializer_list
  "{" @opening
  "}" @closing) @container

(subscript_argument_list
  "[" @opening
  "]" @closing) @container

(field_declaration_list
   "{" @opening
   "}" @closing) @container

(declaration_list
  "{" @opening
  "}" @closing) @container

(template_parameter_list
  "<" @opening
  ">" @closing) @container

(initializer_list
  "{" @opening
  "}" @closing) @container

(template_argument_list
  "<" @opening
  ">" @closing) @container
