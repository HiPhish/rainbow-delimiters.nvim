(array_construction
  "[" @delimiter
  "]" @delimiter) @container
(tuple_construction
  "(" @delimiter
  ")" @delimiter) @container
(tuple_deconstruct_declaration
  "(" @delimiter
  ")" @delimiter) @container
(curly_construction
  "{" @delimiter
  ":"? @delimiter
  "}" @delimiter) @container

(parenthesized
  "(" @delimiter
  ")" @delimiter) @container

(argument_list
  "(" @delimiter
  ")" @delimiter) @container
(parameter_declaration_list
  "(" @delimiter
  ")" @delimiter) @container

(bracket_expression
  "[" @delimiter
  "]" @delimiter) @container
(field_declaration_list
  "[" @delimiter
  "]" @delimiter) @container
(generic_parameter_list
  "[" @delimiter
  "]" @delimiter) @container

(cast
  "[" @delimiter
  "]" @delimiter
  "(" @delimiter
  ")" @delimiter) @container

(term_rewriting_pattern
  "{" @delimiter
  "}" @delimiter) @container
(curly_expression
  "{" @delimiter
  "}" @delimiter) @container
