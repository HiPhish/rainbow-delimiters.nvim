;;; Note: Some patterns are commented out because currently Neovim can capture
;;; only one node at a time.  Once it becomes possible to capture multiple
;;; nodes they should be commented back in.


(function_declaration
  "function" @delimiter
  "end" @delimiter @sentinel) @container

(function_definition
  "function" @delimiter
  "end" @delimiter @sentinel) @container

(if_statement
  "if" @delimiter
  "then" @delimiter
  (elseif_statement
    "elseif" @delimiter
    "then" @delimiter)*
  (else_statement
    "else" @delimiter)?
  "end" @delimiter @sentinel) @container

(while_statement
  "while" @delimiter
  "do" @delimiter
  "end" @delimiter @sentinel) @container

(repeat_statement
  "repeat" @delimiter
  "until" @delimiter @sentinel) @container

(for_statement
  "for" @delimiter
  (for_generic_clause
    "in" @delimiter)?
  "do" @delimiter
  "end" @delimiter @sentinel) @container

(do_statement
  "do" @delimiter
  "end" @delimiter @sentinel) @container


;;; Copied over from rainbow-parens

(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(table_constructor
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(bracket_index_expression
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(field
  "[" @delimiter
  "]" @delimiter @sentinel) @container
