;;; A pair of opening and closing tag with any content in-between. Excludes
;;; self-closing tags or opening tags without closing tag.

(element
  ((start_tag) @opening
   ; (element (self_closing_tag) @intermediate)?
   (end_tag) @closing)) @container

(style_element
  ((start_tag) @opening
   ; (element (self_closing_tag) @intermediate)?
   (end_tag) @closing)) @container
