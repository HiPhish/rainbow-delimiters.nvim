(command_substitution
  "(" @opening
  ")" @closing) @container

(concatenation
  "[" @opening
  "]" @closing) @container

(list_element_access
  "[" @opening
  "]" @closing) @container

(brace_expansion
  "{" @opening
  "}" @closing) @container
