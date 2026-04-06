(command_substitution
  "(" @delimiter
  ")" @delimiter) @container

(concatenation
  "[" @delimiter
  "]" @delimiter) @container

(list_element_access
  "[" @delimiter
  "]" @delimiter) @container

(brace_expansion
  "{" @delimiter
  "}" @delimiter) @container
