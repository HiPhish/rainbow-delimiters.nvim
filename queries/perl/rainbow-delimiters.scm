(signature
  "(" @delimiter
  ")" @delimiter) @container

(block
  "{" @delimiter
  "}" @delimiter) @container

(anonymous_hash_expression
  "{" @delimiter
  "}" @delimiter) @container

(stub_expression
  "(" @delimiter
  ")" @delimiter) @container

(hash_element_expression
  "{" @delimiter
  "}" @delimiter) @container

(array_element_expression
  "[" @delimiter
  "]" @delimiter) @container

(function_call_expression
  "(" @delimiter
  ")" @delimiter) @container

(anonymous_array_expression
  "[" @delimiter
  "]" @delimiter) @container

(slice_expression
  "[" @delimiter
  "]" @delimiter) @container

(conditional_statement
  "(" @delimiter
  ")" @delimiter) @container

(quoted_word_list
  "qw"
  "'" @delimiter
  "'" @delimiter) @container

(quoted_regexp
  "qr"
  "'" @delimiter
  "'" @delimiter) @container

(command_string
  "qx"
  "'" @delimiter
  "'" @delimiter) @container

(interpolated_string_literal
  "qq"
  "'" @delimiter
  "'" @delimiter) @container

(string_literal
  "q"
  "'" @delimiter
  "'" @delimiter) @container

(match_regexp
  "m"
  "'" @delimiter
  "'" @delimiter) @container

(substitution_regexp
  "s"
  "'" @delimiter
  "'" @delimiter
  "'" @delimiter
  "'" @delimiter) @container

(transliteration_expression
  "tr"
  "'" @delimiter
  "'" @delimiter
  "'" @delimiter
  "'" @delimiter) @container

(transliteration_expression
  "y"
  "'" @delimiter
  "'" @delimiter
  "'" @delimiter
  "'" @delimiter) @container
