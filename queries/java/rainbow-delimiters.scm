(class_body
  "{" @delimiter
  "}" @delimiter) @container

(block
  "{" @delimiter
  "}" @delimiter) @container

(switch_block
  "{" @delimiter
  "}" @delimiter) @container

(array_initializer
  "{" @delimiter
  "}" @delimiter) @container

(formal_parameters
  "(" @delimiter
  ")" @delimiter) @container

(resource_specification 
  "(" @delimiter
  ")" @delimiter) @container

(catch_clause 
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression 
  "(" @delimiter
  ")" @delimiter) @container

(cast_expression  
  "(" @delimiter
  ")" @delimiter) @container

(inferred_parameters 
  "(" @delimiter
  ")" @delimiter) @container

(argument_list
  "(" @delimiter
  ")" @delimiter) @container

(annotation_argument_list
  "(" @delimiter
  ")" @delimiter) @container

(for_statement
  "(" @delimiter
  ")" @delimiter) @container

(enhanced_for_statement 
  "(" @delimiter
  ")" @delimiter) @container

(constructor_body
  "{" @delimiter
  "}" @delimiter) @container

;; Treat it as a single delimiter because it will always have the same color
(dimensions) @container @delimiter

(dimensions_expr
  "[" @delimiter
  "]" @delimiter) @container

(array_access
  "[" @delimiter
  "]" @delimiter) @container

(type_arguments
  "<" @delimiter
  ">" @delimiter) @container
