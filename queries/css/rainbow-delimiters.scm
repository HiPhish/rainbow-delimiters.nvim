(block
  "{" @delimiter
  "}" @delimiter) @container

(parenthesized_query
  "(" @delimiter
  ")" @delimiter) @container

(feature_query
  "(" @delimiter
  ")" @delimiter) @container

(arguments
  "(" @delimiter
  ")" @delimiter) @container

(attribute_selector
  "[" @delimiter
  "]" @delimiter) @container
