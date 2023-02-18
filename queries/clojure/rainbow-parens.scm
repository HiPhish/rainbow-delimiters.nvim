(list_lit
  "(" @opening
  ")" @closing) @container

(vec_lit
  "[" @opening
  "]" @closing) @container

(map_lit
  "{" @opening
  "}" @closing) @container

(set_lit
  "{" @opening
  "}" @closing) @container

(anon_fn_lit
  "(" @opening
  ")" @closing) @container
