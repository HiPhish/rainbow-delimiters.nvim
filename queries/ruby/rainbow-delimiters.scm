(block
  "{" @opening
  "}" @closing) @container

(hash
  "{" @opening
  "}" @closing) @container

(array
  "[" @opening
  "]" @closing) @container

(parenthesized_statements
  "(" @opening
  ")" @closing) @container
