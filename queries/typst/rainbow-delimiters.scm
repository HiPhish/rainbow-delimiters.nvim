(group
  "(" @delimiter
  ")" @delimiter) @container

(block
  "{" @delimiter
  "}" @delimiter) @container

(content
  "[" @delimiter
  "]" @delimiter) @container

(math
  "$" @delimiter
  "$" @delimiter) @container

(call
  "(" @delimiter
  ")" @delimiter) @container
