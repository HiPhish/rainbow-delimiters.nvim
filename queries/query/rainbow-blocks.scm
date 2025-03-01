;; Note: These queries are very useful when looking at a large
;; tree of queries like in `InspectTree`
(named_node
  "(" @delimiter
  (identifier) @delimiter
  ")" @delimiter @sentinel) @container

(missing_node
  "(" @delimiter
  "MISSING" @delimiter
  (identifier)? @delimiter
  ")" @delimiter @sentinel) @container

(grouping
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(predicate
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(field_definition
  (identifier) @delimiter @sentinel) @container

;; For more highlighting the following can be added too:
; (parameters
;   (identifier) @delimiter @sentinel) @container
;
; (negated_field
;   (identifier) @delimiter @sentinel) @container
