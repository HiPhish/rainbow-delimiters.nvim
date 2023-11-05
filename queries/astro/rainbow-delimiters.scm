(element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter @sentinel)) @container

(interpolation
  "{" @delimiter
  "}" @delimiter @sentinel) @container
