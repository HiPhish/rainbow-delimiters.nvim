(list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(sequence
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(table
  "{" @delimiter
  ;; NOTE: see example file for usecase
  ;; item:
  ;;   (table_pair
  ;;      key: (symbol) @delimiter @_colon
  ;;      (#eq? @_colon ":"))*
  "}" @delimiter @sentinel) @container
