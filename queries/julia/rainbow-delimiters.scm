(vector_expression
  "[" @delimiter
  "]" @delimiter) @container

(matrix_expression
  "[" @delimiter
  "]" @delimiter) @container

(argument_list
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(comprehension_expression
  "[" @delimiter
  "]" @delimiter) @container

(tuple_expression
  "(" @delimiter
  ")" @delimiter) @container

(curly_expression
  "{" @delimiter
  "}" @delimiter) @container
