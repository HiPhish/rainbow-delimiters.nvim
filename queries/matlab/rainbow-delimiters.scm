(function_call
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(function_arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(lambda
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesis
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(matrix
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(multioutput_variable
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(function_call
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(cell
  "{" @delimiter
  "}" @delimiter @sentinel) @container
