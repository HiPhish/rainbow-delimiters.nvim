(argument
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(array
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(array_dereference
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(array_ref
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array_ref
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(hash_access_variable
  "->{" @delimiter
  "}" @delimiter @sentinel) @container

(hash_access_variable
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(hash_ref
  "+" @delimiter
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(multi_var_declaration
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(standalone_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(parenthesized_argument
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(word_list_qw
  (start_delimiter_qw) @delimiter
  (end_delimiter_qw) @delimiter @sentinel) @container

(regex_pattern_qr
  (start_delimiter) @delimiter
  (end_delimiter) @delimiter @sentinel) @container

(command_qx_quoted
  (start_delimiter) @delimiter
  (end_delimiter) @delimiter @sentinel) @container

(string_qq_quoted
  (start_delimiter) @delimiter
  (end_delimiter) @delimiter @sentinel) @container

(patter_matcher_m
  (start_delimiter) @delimiter
  (end_delimiter) @delimiter @sentinel) @container

(substitution_pattern_s
  (start_delimiter) @delimiter
  (separator_delimiter) @delimiter
  (end_delimiter) @delimiter @sentinel) @container

(transliteration_tr_or_y
  (start_delimiter) @delimiter
  (separator_delimiter) @delimiter
  (end_delimiter) @delimiter @sentinel) @container
