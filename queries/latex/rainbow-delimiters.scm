(curly_group
  "{" @opening
  "}" @closing) @container

(curly_group_text
  "{" @opening
  "}" @closing) @container

(curly_group_text_list
  "{" @opening
  "}" @closing) @container

(inline_formula
  "$" @opening
  "$" @closing) @container
