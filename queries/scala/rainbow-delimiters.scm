(template_body
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(case_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container


(tuple_expression 
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression 
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(type_parameters
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_arguments
  "[" @delimiter
  "]" @delimiter @sentinel) @container
