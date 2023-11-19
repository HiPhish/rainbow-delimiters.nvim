(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(parenthesized_query
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(feature_query
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(attribute_selector
  "[" @delimiter
  "]" @delimiter @sentinel) @container
