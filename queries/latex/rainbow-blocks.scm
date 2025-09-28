(inline_formula
  "$" @delimiter
  "$" @delimiter @sentinel) @container

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

(brack_group_key_value
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(curly_group
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(label_definition
  "\\label" @delimiter
  name: (curly_group_label
    "{" @delimiter
    "}" @delimiter @sentinel) @container)

(label_reference
  "\\ref" @delimiter
  (curly_group_label_list
    "{" @delimiter
    "}" @delimiter @sentinel)) @container


(curly_group_text_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(curly_group_path
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(curly_group_path_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(curly_group_author_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container
