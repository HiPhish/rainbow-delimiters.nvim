(list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(loop_widget
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(array
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(string_interpolation
  "${" @delimiter
  "}" @delimiter @sentinel) @container

(expr
  "{" @delimiter
  "}" @delimiter @sentinel) @container
