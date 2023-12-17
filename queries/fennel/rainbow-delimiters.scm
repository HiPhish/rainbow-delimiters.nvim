(list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(table
  "{" @delimiter
  (":" @delimiter _)*
  "}" @delimiter @sentinel) @container

(sequential_table
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(fn
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(lambda
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(let
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(set
  "(" @delimiter
  ")" @delimiter @sentinel) @container


;;; NOTE: The following queries contain one set of outer parentheses and one
;;;       set of inner parentheses, but both are on the same level of the tree.
;;;       Thus we cannot match the inner ones one level deeper than the outer
;;;       ones.

(each
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(collect
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(icollect
  "(" @delimiter
  ")" @delimiter @sentinel) @container

;;; TODO: add these when treesitter parser
;;;       adds support for fennel 1.1.1

;; (fcollect
;;   "(" @delimiter
;;   ")" @delimiter @sentinel) @container
;;
;; (fcollect
;;   "[" @delimiter
;;   "]" @delimiter @sentinel) @container

(accumulate
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(accumulate
  "[" @delimiter
  "]" @delimiter @sentinel) @container

;;; TODO: add these when treesitter parser
;;;       adds support for fennel 1.3.0

;; (faccumulate
;;   "(" @delimiter
;;   ")" @delimiter @sentinel) @container
;;
;; (faccumulate
;;   "[" @delimiter
;;   "]" @delimiter @sentinel) @container

(for
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_clause
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(var
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameters
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(let_clause
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(quoted_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(local
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(multi_value_binding
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(hashfn
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(match
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(table_binding
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(sequential_table_pattern
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(sequential_table_binding
  "[" @delimiter
  "]" @delimiter @sentinel) @container
