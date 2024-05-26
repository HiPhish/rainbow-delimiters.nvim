(argument_list_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(attribute
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(compound_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(function_declaration
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(loop_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(postfix_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(struct_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(subscript_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_declaration
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(variable_qualifier
  "<" @delimiter
  ">" @delimiter @sentinel) @container
