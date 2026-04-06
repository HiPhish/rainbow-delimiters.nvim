;; Note: These queries are very useful when looking at a large
;; tree of queries like in `InspectTree`
(named_node
  "(" @delimiter
  (identifier) @delimiter
  ")" @delimiter) @container

(missing_node
  "(" @delimiter
  "MISSING" @delimiter
  (identifier)? @delimiter
  ")" @delimiter) @container

(grouping
  "(" @delimiter
  ")" @delimiter) @container

(list
  "[" @delimiter
  "]" @delimiter) @container

(predicate
  "(" @delimiter
  ")" @delimiter) @container

(field_definition
  (identifier) @delimiter) @container

;; For more highlighting the following can be added too:
; (parameters
;   (identifier) @delimiter) @container
;
; (negated_field
;   (identifier) @delimiter) @container
