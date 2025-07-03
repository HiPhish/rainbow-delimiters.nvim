;; This is mostly identical to Python, without `generator_expression`.
;; NOTE: if you update queries for Python, please consider adding the changes
;; to this file as well, given that the tree-sitter's node types exist. See
;; https://github.com/amaanq/tree-sitter-starlark/blob/master/src/node-types.json

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

(string
  (interpolation
    "{" @delimiter
    "}" @delimiter @sentinel) @container)

(format_expression
  "{" @delimiter
  "}" @delimiter @sentinel) @container
