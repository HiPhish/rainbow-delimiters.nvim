;;; A Vue file is made up of top-level tags which contain code written in other
;;; languages

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

(template_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)) @container

(script_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)) @container

(style_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)) @container

(interpolation
  "{{" @delimiter
  "}}" @delimiter) @container
