(table
  "[" @delimiter
  "]" @delimiter) @container

(array
  "[" @delimiter
  "]" @delimiter) @container

(inline_table
  "{" @delimiter
  "}" @delimiter) @container

(table_array_element
  "[[" @delimiter
  "]]" @delimiter) @container
