(vector_expression
  "[" @opening
  "]" @closing) @container

(matrix_expression
  "[" @opening
  "]" @closing) @container

(parameter_list
  "(" @opening
  ")" @closing) @container

(argument_list
  "(" @opening
  ")" @closing) @container

(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(comprehension_expression
  "[" @opening
  "]" @closing) @container
