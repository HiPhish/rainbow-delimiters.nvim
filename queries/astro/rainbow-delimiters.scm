(element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)) @container

(element
  (self_closing_tag
    "<" @delimiter
    (tag_name) @delimiter
    "/>" @delimiter)) @container

(style_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)) @container

(html_interpolation
  "{" @delimiter
  "}" @delimiter) @container
