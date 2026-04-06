;; This is mostly identical to Python, without `generator_expression`.
;; NOTE: if you update queries for Python, please consider adding the changes
;; to this file as well, given that the tree-sitter's node types exist. See
;; https://github.com/amaanq/tree-sitter-starlark/blob/master/src/node-types.json

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

(string
  (interpolation
    "{" @delimiter
    "}" @delimiter) @container)

(format_expression
  "{" @delimiter
  "}" @delimiter) @container
