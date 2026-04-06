(argument_list_expression
  "(" @delimiter
  ")" @delimiter) @container

(attribute
  "(" @delimiter
  ")" @delimiter) @container

(compound_statement
  "{" @delimiter
  "}" @delimiter) @container

(function_declaration
  "(" @delimiter
  ")" @delimiter) @container

(for_statement
  "(" @delimiter
  ")" @delimiter) @container

(loop_statement
  "{" @delimiter
  "}" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(postfix_expression
  "[" @delimiter
  "]" @delimiter) @container

(struct_declaration
  "{" @delimiter
  "}" @delimiter) @container

(subscript_expression
  "[" @delimiter
  "]" @delimiter) @container

(type_declaration
  "<" @delimiter
  ">" @delimiter) @container

(variable_qualifier
  "<" @delimiter
  ">" @delimiter) @container
