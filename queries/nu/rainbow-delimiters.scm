(flag_capsule
  "(" @delimiter
  ")" @delimiter) @container

(expr_interpolated
  "(" @delimiter
  ")" @delimiter) @container

(expr_parenthesized
  ["(" "...("] @delimiter
  ")" @delimiter) @container

(val_table
  "[" @delimiter
  "]" @delimiter) @container

(val_list
  ["[" "...["] @delimiter
  "]" @delimiter) @container

(val_nothing
  "(" @delimiter
  ")" @delimiter) @container

(block
  "{" @delimiter
  "}" @delimiter) @container

(ctrl_match
  "{" @delimiter
  "}" @delimiter) @container

(val_record
  ["{" "...{"] @delimiter
  "}" @delimiter) @container

(val_closure
  "{" @delimiter
  "}" @delimiter) @container

(collection_type
  "<" @delimiter
  ">" @delimiter) @container

(list_type
  "<" @delimiter
  ">" @delimiter) @container

(parameter_bracks
  "[" @delimiter
  "]" @delimiter) @container

(parameter_pipes
  "|" @delimiter
  "|" @delimiter) @container
