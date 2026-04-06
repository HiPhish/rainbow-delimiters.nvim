(atom
  "(" @delimiter
  ")" @delimiter) @container

(atom
  "[" @delimiter
  "]" @delimiter) @container

(array_pattern
  "[" @delimiter
  "]" @delimiter) @container

(record_pattern
  "{" @delimiter
  "}" @delimiter) @container

(uni_record
  "{" @delimiter
  "}" @delimiter) @container

(match_expr
  "{" @delimiter
  "}" @delimiter) @container

(chunk_expr
  (interpolation_start) @delimiter
  (interpolation_end) @delimiter) @container
