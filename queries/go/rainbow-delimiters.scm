(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(import_spec_list
  "(" @opening
  ")" @closing) @container

(var_declaration
  "(" @opening
  ")" @closing) @container

(const_declaration
  "(" @opening
  ")" @closing) @container

(field_declaration_list
  "{" @opening
  "}" @closing) @container

(argument_list
  "(" @opening
  ")" @closing) @container

(parameter_list
  "(" @opening
  ")" @closing) @container

(block
  "{" @opening
  "}" @closing) @container

(expression_switch_statement
  "{" @opening
  "}" @closing) @container

(type_switch_statement
  "{" @opening
  "}" @closing) @container

(literal_value
  "{" @opening
  "}" @closing) @container

(slice_type
  "[" @opening
  "]" @closing) @container

(map_type
  "[" @opening
  "]" @closing) @container

(interface_type
  "{" @opening
  "}" @closing) @container

(type_parameter_list
  "[" @opening
  "]" @closing) @container

(type_arguments
  "[" @opening
  "]" @closing) @container
