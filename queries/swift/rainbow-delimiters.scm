(class_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

;; Support for function declarations
(function_declaration
  "(" @delimiter
  ")" @delimiter @sentinel) @container

;; Support for functions 
(function_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(value_arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

;; Support for closures
(lambda_literal
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(switch_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

;; Support for computed properties
(computed_property
  "{" @delimiter
  "}" @delimiter @sentinel) @container

;; Support for enum bodies
(enum_class_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

;; Support for didSet and willSet blocks
(willset_didset_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(didset_clause
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(willset_clause
  "{" @delimiter
  "}" @delimiter @sentinel) @container

;; Array matching
(array_literal
  "[" @delimiter
  "]" @delimiter @sentinel) @container

;; Dictionary matching
(dictionary_literal
  "[" @delimiter
  "]" @delimiter @sentinel) @container

;; Tuple matching
(tuple_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter @sentinel) @container
