(named_node
  "(" @delimiter
  (identifier) @delimiter
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
