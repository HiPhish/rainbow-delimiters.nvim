(list_lit
  "(" @delimiter
  ")" @delimiter) @container

(vec_lit
  "[" @delimiter
  "]" @delimiter) @container

(map_lit
  "{" @delimiter
  "}" @delimiter) @container

(set_lit
  "{" @delimiter
  "}" @delimiter) @container

(anon_fn_lit
  "(" @delimiter
  ")" @delimiter) @container
