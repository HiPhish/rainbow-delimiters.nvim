(class_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array_initializer
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(formal_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(resource_specification 
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(catch_clause 
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression 
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(cast_expression  
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(inferred_parameters 
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(annotation_argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(enhanced_for_statement 
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(constructor_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

;; Treat it as a single delimiter because it will always have the same color
(dimensions) @container @delimiter @sentinel

(dimensions_expr
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array_access
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter @sentinel) @container
