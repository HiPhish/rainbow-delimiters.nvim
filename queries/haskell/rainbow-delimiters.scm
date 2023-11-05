(exp_parens
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(exp_tuple
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(con_unit
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(exports
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(export_names
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(import_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(import_item
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(type_parens
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(type_tuple
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(pat_parens
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(pat_tuple
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(pat_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(exp_lambda
  "\\" @delimiter
  @sentinel) @container

(type_tuple
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(deriving
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(record_fields
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(exp_record
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(pat_fields
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(exp_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(exp_list_comprehension
  "[" @delimiter
  "|" @delimiter
  "]" @delimiter @sentinel) @container

(exp_arithmetic_sequence
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(context
  "(" @delimiter
   ")" @delimiter @sentinel) @container

(con_list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(exp_section_right
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(exp_name
  "(" @delimiter
  ")" @delimiter @sentinel) @container
