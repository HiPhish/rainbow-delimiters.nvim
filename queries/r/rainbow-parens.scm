(call
  "(" @opening
  ")" @closing) @container

(subset
  "[" @opening
  "]" @closing) @container

(subset2
  "[[" @opening
  "]]" @closing) @container

(if
  "(" @opening
  ")" @closing) @container

(brace_list
  "{" @opening
  "}" @closing) @container
