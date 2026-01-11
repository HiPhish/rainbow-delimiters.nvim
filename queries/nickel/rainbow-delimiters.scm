(atom
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(atom
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array_pattern
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(record_pattern
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(uni_record
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(match_expr
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(chunk_expr
  (interpolation_start) @delimiter
  (interpolation_end) @delimiter @sentinel) @container
