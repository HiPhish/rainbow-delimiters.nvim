(par_tup_lit
  "(" @opening
  ")" @closing) @container

(par_arr_lit
  "@(" @opening
  ")" @closing) @container

(sqr_tup_lit
  "[" @opening
  "]" @closing) @container

(sqr_arr_lit
  "@[" @opening
  "]" @closing) @container

(struct_lit
  "{" @opening
  "}" @closing) @container

(tbl_lit
  "@{" @opening
  "}" @closing) @container

