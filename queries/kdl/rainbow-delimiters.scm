(node_children
  "{" @delimiter
  "}"  @delimiter @sentinel) @container

(type
  "(" @delimiter
  (annotation_type)
  ")" @delimiter @sentinel) @container
