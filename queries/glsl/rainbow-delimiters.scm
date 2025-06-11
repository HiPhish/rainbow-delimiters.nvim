(layout_qualifiers
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(field_declaration_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(compound_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array_declarator
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(subscript_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(parameter_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container
