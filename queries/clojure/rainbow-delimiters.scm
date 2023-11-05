(list_lit
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(vec_lit
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(map_lit
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(set_lit
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(anon_fn_lit
  "(" @delimiter
  ")" @delimiter @sentinel) @container
