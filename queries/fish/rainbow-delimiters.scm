(command_substitution
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(concatenation
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(list_element_access
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(brace_expansion
  "{" @delimiter
  "}" @delimiter @sentinel) @container
