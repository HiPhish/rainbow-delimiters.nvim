(table
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(inline_table
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(table_array_element
  "[[" @delimiter
  "]]" @delimiter @sentinel) @container
