(inline_formula
  "$" @delimiter
  "$" @delimiter) @container

(generic_environment
  (begin) @delimiter
  (end)   @delimiter) @container

(math_environment
  (begin) @delimiter
  (end)   @delimiter) @container

(math_delimiter
  left_command: _ @delimiter
  left_delimiter: _ @delimiter
  right_command: _ @delimiter
  right_delimiter: _ @delimiter) @container

(brack_group_key_value
  "[" @delimiter
  "]" @delimiter) @container

(curly_group
  "{" @delimiter
  "}" @delimiter) @container

(label_definition
  "\\label" @delimiter
  name: (curly_group_label
    "{" @delimiter
    "}" @delimiter) @container)

(label_reference
  "\\ref" @delimiter
  (curly_group_label_list
    "{" @delimiter
    "}" @delimiter)) @container


(curly_group_text_list
  "{" @delimiter
  "}" @delimiter) @container

(curly_group_path
  "{" @delimiter
  "}" @delimiter) @container

(curly_group_path_list
  "{" @delimiter
  "}" @delimiter) @container

(curly_group_author_list
  "{" @delimiter
  "}" @delimiter) @container
