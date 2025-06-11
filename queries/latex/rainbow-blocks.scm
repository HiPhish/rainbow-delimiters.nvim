(inline_formula
  "$" @delimiter
  "$" @delimiter @sentinel) @container

(inline_formula
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(generic_environment
  (begin) @delimiter
  (end)   @delimiter @sentinel) @container

(math_environment
  (begin) @delimiter
  (end)   @delimiter @sentinel) @container

(math_delimiter
  left_command: _ @delimiter
  left_delimiter: _ @delimiter @sentinel
  right_command: _ @delimiter
  right_delimiter: _ @delimiter @sentinel) @container

(curly_group
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(label_definition
  name: (curly_group_text
  "{" @delimiter
  "}" @delimiter @sentinel) @container
)

(curly_group_text_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container
