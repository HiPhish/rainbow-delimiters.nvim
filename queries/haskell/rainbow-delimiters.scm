(parens
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(unit
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(exports
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(children
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(import_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(prefix_id
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(fields
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(record
  "{" @delimiter
  "}" @delimiter @sentinel) @container
