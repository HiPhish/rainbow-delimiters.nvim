(class_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(function_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(control_structure_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container


(lambda_literal
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(primary_constructor
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(function_value_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(value_arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(multi_variable_declaration
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(when_expression
  (when_subject
    "(" @delimiter
    ")" @delimiter)?
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(indexing_suffix
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_parameters
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter @sentinel) @container
