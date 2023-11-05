(par_tup_lit
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(par_arr_lit
  "@(" @delimiter
  ")" @delimiter @sentinel) @container

(sqr_tup_lit
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(sqr_arr_lit
  "@[" @delimiter
  "]" @delimiter @sentinel) @container

(struct_lit
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(tbl_lit
  "@{" @delimiter
  "}" @delimiter @sentinel) @container
