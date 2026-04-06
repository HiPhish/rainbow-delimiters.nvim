(class_body
  "{" @delimiter
  "}" @delimiter) @container

(function_body
  "{" @delimiter
  "}" @delimiter) @container

(control_structure_body
  "{" @delimiter
  "}" @delimiter) @container


(lambda_literal
  "{" @delimiter
  "}" @delimiter) @container

(primary_constructor
  "(" @delimiter
  ")" @delimiter) @container

(function_value_parameters
  "(" @delimiter
  ")" @delimiter) @container

(value_arguments
  "(" @delimiter
  ")" @delimiter) @container

(multi_variable_declaration
  "(" @delimiter
  ")" @delimiter) @container

(for_statement
  "(" @delimiter
  ")" @delimiter) @container

(when_expression
  (when_subject
    "(" @delimiter
    ")" @delimiter)?
  "{" @delimiter
  "}" @delimiter) @container

(indexing_suffix
  "[" @delimiter
  "]" @delimiter) @container

(type_parameters
  "<" @delimiter
  ">" @delimiter) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter) @container
