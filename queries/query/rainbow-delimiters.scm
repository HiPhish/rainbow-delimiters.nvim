(named_node
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(missing_node
  "(" @delimiter
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
