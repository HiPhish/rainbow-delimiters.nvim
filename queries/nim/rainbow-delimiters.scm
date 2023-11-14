(array_construction
  "[" @delimiter
  "]" @delimiter @sentinel) @container
(tuple_construction
  "(" @delimiter
  ")" @delimiter @sentinel) @container
(tuple_deconstruct_declaration
  "(" @delimiter
  ")" @delimiter @sentinel) @container
(curly_construction
  "{" @delimiter
  ":"? @delimiter
  "}" @delimiter @sentinel) @container

(parenthesized
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container
(parameter_declaration_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(bracket_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container
(field_declaration_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container
(generic_parameter_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(cast
  type: "[" @delimiter
  type: "]" @delimiter
  value: "(" @delimiter
  value: ")" @delimiter @sentinel) @container

(term_rewriting_pattern
  "{" @delimiter
  "}" @delimiter @sentinel) @container
(curly_expression
  "{" @delimiter
  "}" @delimiter @sentinel) @container
