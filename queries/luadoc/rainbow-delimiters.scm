(function_type
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_type
  "(" @delimiter
  ")" @delimiter) @container

;;; I wanted to use something like
; (union_type
;   "|" @delimiter
; ) @container
;;; too, but it doesn't fully work with the current parser

(array_type
  "[" @delimiter
  "]" @delimiter) @container

(table_type
  "<" @delimiter
  ">" @delimiter) @container

(table_literal_type
  "{" @delimiter
  "}" @delimiter) @container

(indexed_field
  "[" @delimiter
  "]" @delimiter) @container

(tuple_type
  "(" @delimiter
  ")" @delimiter) @container

;;; Dictionary-type tables cannot be matched.  Their syntax is 
;;;    { [string]: VALUE_TYPE }
;;; The type of the key is written in square brackets.  The square brackets and
;;; their contents need to be their own node, but instead they are all on the
;;; same level without any container node.
;;;
;;; See also https://github.com/tree-sitter-grammars/tree-sitter-luadoc/issues/11
;;;          https://luals.github.io/wiki/annotations/#documenting-types
; (_
;   "[" @delimiter
;   .
;   field: (_)
;   .
;   "]" @delimiter) @container
