;;; Note: Some patterns are commented out because currently Neovim can capture
;;; only one node at a time.  Once it becomes possible to capture multiple
;;; nodes they should be commented back in.


(function_declaration
  "function" @opening
  "end" @closing) @container

(if_statement
  "if" @opening
  ; "then" @opening
  ; (elseif_statement
  ;   "elseif" @intermediate
  ;   "then" @intermediate)*
  ; (else_statement
  ;   "else" @intermediate)?
  "end" @closing) @container

(while_statement
  "while" @opening
  ; "do" @opening
  "end" @closing) @container

(repeat_statement
  "repeat" @opening
  "until" @closing) @container

(for_statement
  "for" @opening
  ; clause: [(for_generic_clause
  ;            "in" @opening)
  ;          (for_numeric_clause)]
  ; "do" @opening
  "end" @closing) @container

(do_statement
  "do" @opening
  "end" @closing) @container


;;; Copied over from rainbow-parens

(arguments
  "(" @opening
  ")" @closing) @container

(parameters
  "(" @opening
  ")" @closing) @container

(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(table_constructor
  "{" @opening
  "}" @closing) @container

(bracket_index_expression
  "[" @opening
  "]" @closing) @container
