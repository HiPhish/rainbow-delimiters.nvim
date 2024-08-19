(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(import_spec_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(var_spec_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(const_declaration
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(type_assertion_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(field_declaration_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameter_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(expression_switch_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(type_switch_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(literal_value
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(slice_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(map_type
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(interface_type
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(type_parameter_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_arguments
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(index_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(slice_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container
