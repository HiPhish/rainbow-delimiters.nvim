(list
  "(" @opening
  ")" @closing) @container

(table
  "{" @opening
  (":" @intermediate)*
  "}" @closing) @container

(sequential_table
  "[" @opening
  "]" @closing) @container

(fn
  "(" @opening
  ")" @closing) @container

(lambda
  "(" @opening
  ")" @closing) @container

(let
  "(" @opening
  ")" @closing) @container

(set
  "(" @opening
  ")" @closing) @container


;;; BUG: regarding the next 6 pairs of queries:
;;;      since both pairs of delimiters
;;;      are direct children of the same `TSNode`
;;;      they get highligthed in different colours

;;; NOTE: https://github.com/neovim/neovim/pull/17099

(each
  "(" @opening
  ")" @closing) @container

(each
  "[" @opening
  "]" @closing) @container

(collect
  "(" @opening
  ")" @closing) @container

(collect
  "[" @opening
  "]" @closing) @container

(icollect
  "(" @opening
  ")" @closing) @container

(icollect
  "[" @opening
  "]" @closing) @container

;;; TODO: add these when treesitter parser
;;;       adds support for fennel 1.1.1

;; (fcollect
;;   "(" @opening
;;   ")" @closing) @container
;;
;; (fcollect
;;   "[" @opening
;;   "]" @closing) @container

(accumulate
  "(" @opening
  ")" @closing) @container

(accumulate
  "[" @opening
  "]" @closing) @container

;;; TODO: add these when treesitter parser
;;;       adds support for fennel 1.3.0

;; (faccumulate
;;   "(" @opening
;;   ")" @closing) @container
;;
;; (faccumulate
;;   "[" @opening
;;   "]" @closing) @container

;;; TODO: (reo101) swap out the above queries
;;;       for these (below) when 17099 (see NOTE) is merged

;; (each
;;    ["[" ")"]+ @opening
;;    ["]" ")"]+ @closing) @container
;;
;; (collect
;;    ["[" ")"]+ @opening
;;    ["]" ")"]+ @closing) @container
;;
;; (icollect
;;    ["[" ")"]+ @opening
;;    ["]" ")"]+ @closing) @container
;;
;; (fcollect
;;    ["[" ")"]+ @opening
;;    ["]" ")"]+ @closing) @container
;;
;; (accumulate
;;    ["[" ")"]+ @opening
;;    ["]" ")"]+ @closing) @container
;;
;; (faccumulate
;;    ["[" ")"]+ @opening
;;    ["]" ")"]+ @closing) @container

(for
  "(" @opening
  ")" @closing) @container

(for_clause
  "[" @opening
  "]" @closing) @container

(var
  "(" @opening
  ")" @closing) @container

(parameters
  "[" @opening
  "]" @closing) @container

(let_clause
  "[" @opening
  "]" @closing) @container

(quoted_list
  "(" @opening
  ")" @closing) @container

(local
  "(" @opening
  ")" @closing) @container

(multi_value_binding
  "(" @opening
  ")" @closing) @container

(hashfn
  "(" @opening
  ")" @closing) @container

(match
  "(" @opening
  ")" @closing) @container

(sequential_table_pattern
  "[" @opening
  "]" @closing) @container

(sequential_table_binding
  "[" @opening
  "]" @closing) @container
