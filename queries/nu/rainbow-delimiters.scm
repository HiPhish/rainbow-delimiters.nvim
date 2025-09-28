(flag_capsule
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(expr_interpolated
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(expr_parenthesized
  ["(" "...("] @delimiter
  ")" @delimiter @sentinel) @container

(val_table
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(val_list
  ["[" "...["] @delimiter
  "]" @delimiter @sentinel) @container

(val_nothing
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(ctrl_match
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(val_record
  ["{" "...{"] @delimiter
  "}" @delimiter @sentinel) @container

(val_closure
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(collection_type
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(list_type
  "<" @delimiter
  ">" @delimiter @sentinel) @container

(parameter_bracks
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(parameter_pipes
  "|" @delimiter
  "|" @delimiter) @container
