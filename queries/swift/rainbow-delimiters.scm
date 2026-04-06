(class_body
  "{" @delimiter
  "}" @delimiter) @container

;; Support for function declarations
(function_declaration
  "(" @delimiter
  ")" @delimiter) @container

;; Support for functions 
(function_body
  "{" @delimiter
  "}" @delimiter) @container

(value_arguments
  "(" @delimiter
  ")" @delimiter) @container

;; Support for closures
(lambda_literal
  "{" @delimiter
  "}" @delimiter) @container

(switch_statement
  "{" @delimiter
  "}" @delimiter) @container

;; Support for computed properties
(computed_property
  "{" @delimiter
  "}" @delimiter) @container

;; Support for enum bodies
(enum_class_body
  "{" @delimiter
  "}" @delimiter) @container

;; Support for didSet and willSet blocks
(willset_didset_block
  "{" @delimiter
  "}" @delimiter) @container

(didset_clause
  "{" @delimiter
  "}" @delimiter) @container

(willset_clause
  "{" @delimiter
  "}" @delimiter) @container

;; Array matching
(array_literal
  "[" @delimiter
  "]" @delimiter) @container

;; Dictionary matching
(dictionary_literal
  "[" @delimiter
  "]" @delimiter) @container

;; Tuple matching
(tuple_expression
  "(" @delimiter
  ")" @delimiter) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter) @container
