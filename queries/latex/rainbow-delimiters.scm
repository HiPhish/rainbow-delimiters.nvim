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
