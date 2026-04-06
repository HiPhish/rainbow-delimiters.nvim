(par_tup_lit
  "(" @delimiter
  ")" @delimiter) @container

(par_arr_lit
  "@(" @delimiter
  ")" @delimiter) @container

(sqr_tup_lit
  "[" @delimiter
  "]" @delimiter) @container

(sqr_arr_lit
  "@[" @delimiter
  "]" @delimiter) @container

(struct_lit
  "{" @delimiter
  "}" @delimiter) @container

(tbl_lit
  "@{" @delimiter
  "}" @delimiter) @container
