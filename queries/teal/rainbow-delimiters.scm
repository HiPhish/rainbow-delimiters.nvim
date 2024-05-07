(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(table_constructor
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(table_entry
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(index
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(field
  "[" @delimiter
  "]" @delimiter @sentinel) @container
