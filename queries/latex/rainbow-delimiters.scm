(brack_group_key_value
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(curly_group
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(curly_group_text
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(curly_group_text_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(inline_formula
  "$" @delimiter
  "$" @delimiter @sentinel) @container

(curly_group_label
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(curly_group_label_list
  "{" @delimiter
  "}" @delimiter) @container

(curly_group_path
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(curly_group_path_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(curly_group_author_list
  "{" @delimiter
  "}" @delimiter @sentinel) @container
