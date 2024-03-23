;; NOTE: When updating this file update the Starlark test file as well if
;; applicable.

(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(list_pattern
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(list_comprehension
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(dictionary
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(dict_pattern
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(dictionary_comprehension
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(set
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(set_comprehension
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(tuple
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple_pattern
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(generator_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(subscript
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_parameter
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(import_from_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(string
  (interpolation
    "{" @delimiter
    "}" @delimiter @sentinel) @container)
