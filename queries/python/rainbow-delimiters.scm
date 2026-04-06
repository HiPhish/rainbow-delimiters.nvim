;; NOTE: When updating this file update the Starlark test file as well if
;; applicable.

(list
  "[" @delimiter
  "]" @delimiter) @container

(list_pattern
  "[" @delimiter
  "]" @delimiter) @container

(list_comprehension
  "[" @delimiter
  "]" @delimiter) @container

(dictionary
  "{" @delimiter
  "}" @delimiter) @container

(dict_pattern
  "{" @delimiter
  "}" @delimiter) @container

(dictionary_comprehension
  "{" @delimiter
  "}" @delimiter) @container

(set
  "{" @delimiter
  "}" @delimiter) @container

(set_comprehension
  "{" @delimiter
  "}" @delimiter) @container

(tuple
  "(" @delimiter
  ")" @delimiter) @container

(tuple_pattern
  "(" @delimiter
  ")" @delimiter) @container

(generator_expression
  "(" @delimiter
  ")" @delimiter) @container

(parameters
  "(" @delimiter
  ")" @delimiter) @container

(argument_list
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(subscript
  "[" @delimiter
  "]" @delimiter) @container

(type_parameter
  "[" @delimiter
  "]" @delimiter) @container

(import_from_statement
  "(" @delimiter
  ")" @delimiter) @container

(string
  (interpolation
    "{" @delimiter
    "}" @delimiter) @container)

(format_expression
  "{" @delimiter
  "}" @delimiter) @container

(with_clause
  "(" @delimiter
  ")" @delimiter) @container
