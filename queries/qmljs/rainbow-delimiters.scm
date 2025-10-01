(arguments
  "(" @delimiter
  ")" @delimiter) @container

(array
  "[" @delimiter
  "]" @delimiter) @container

(formal_parameters
  "(" @delimiter
  ")" @delimiter) @container

(object
  "{" @delimiter
  "}" @delimiter) @container

(statement_block
  "{" @delimiter
  "}" @delimiter) @container

(template_substitution
  "${" @delimiter
  "}" @delimiter) @container

(ui_object_initializer
  "{" @delimiter
  "}" @delimiter) @container

(ui_signal_parameters
  "(" @delimiter
  ")" @delimiter) @container
