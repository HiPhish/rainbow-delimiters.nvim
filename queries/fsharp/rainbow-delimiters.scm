(argument_patterns
  ("(" @delimiter ")" @delimiter)*) @container

(ce_expression
  "{" @delimiter
  "}" @delimiter) @container

(generic_type
  "<" @delimiter
  ">" @delimiter) @container

(list_pattern
  "[" @delimiter
  "]" @delimiter) @container

(array_pattern
  "[|" @delimiter
  "|]" @delimiter) @container

(paren_expression
  "(" @delimiter
  ")" @delimiter) @container

(paren_pattern
  "(" @delimiter
  ")" @delimiter) @container

(paren_type
  "(" @delimiter
  ")" @delimiter) @container

(record_type_defn
  "{" @delimiter
  "}" @delimiter) @container

;; This one is weird because the `unit` node has no children, so it is at the
;; same time container and a delimiter
(unit) @delimiter @container
