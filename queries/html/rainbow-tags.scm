;;; A pair of opening and closing tag with any content in-between. Excludes
;;; self-closing tags or opening tags without closing tag.
(element
  (((start_tag) @opening)
   _*
   ((end_tag) @closing))) @container
