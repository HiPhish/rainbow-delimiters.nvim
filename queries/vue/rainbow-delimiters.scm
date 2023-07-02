;;; A Vue file is made up of top-level tags which contain code written in other
;;; languages

(element
  (start_tag) @opening
  (end_tag)   @closing) @container

(template_element
  (start_tag) @opening
  (end_tag)   @closing) @container

(script_element
  (start_tag) @opening
  (end_tag)   @closing) @container

(style_element
  (start_tag) @opening
  (end_tag)   @closing) @container
