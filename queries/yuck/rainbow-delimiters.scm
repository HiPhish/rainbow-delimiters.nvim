(list
  "(" @delimiter
  ")" @delimiter) @container

(loop_widget
  "(" @delimiter
  ")" @delimiter) @container

(array
  "[" @delimiter
  "]" @delimiter) @container

(string_interpolation
  "${" @delimiter
  "}" @delimiter) @container

(expr
  "{" @delimiter
  "}" @delimiter) @container
