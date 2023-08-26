(argument
  "(" @opening
  ")" @closing) @container

(array
  "(" @opening
  ")" @closing) @container

(array_dereference
  "{" @opening
  "}" @closing) @container

(array_ref
  "[" @opening
  "]" @closing) @container

(block
  "{" @opening
  "}" @closing) @container

(hash_access_variable
  "->{" @opening
  "}" @closing) @container

(hash_ref
  "{" @opening
  "}" @closing) @container

(multi_var_declaration
  "(" @opening
  ")" @closing) @container

(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(standalone_block
  "{" @opening
  "}" @closing) @container

(parenthesized_argument
  "(" @opening
  ")" @closing) @container

(list_block
  "{" @opening
  "}" @closing) @container

(array_ref
  "(" @opening
  ")" @closing) @container

(word_list_qw
  (start_delimiter_qw) @opening
  (end_delimiter_qw) @closing) @container

(regex_pattern_qr
  (start_delimiter) @opening
  (end_delimiter) @closing) @container

(command_qx_quoted
  (start_delimiter) @opening
  (end_delimiter) @closing) @container

(string_qq_quoted
  (start_delimiter) @opening
  (end_delimiter) @closing) @container

(patter_matcher_m
  (start_delimiter) @opening
  (end_delimiter) @closing) @container

(substitution_pattern_s
  (start_delimiter) @opening
  (separator_delimiter) @intermediate
  (end_delimiter) @closing) @container

(transliteration_tr_or_y
  (start_delimiter) @opening
  (separator_delimiter) @intermediate
  (end_delimiter) @closing) @container
