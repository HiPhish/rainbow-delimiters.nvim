;;; A pair of delimiter tags with any content in-between.
;;; Last tag should be a sentinel.

;;; If instead you want rainbow-delimiters to only highlight
;;; the tag names without any of "<", "</", ">" or "/>", then
;;; you can make your own query file, e.g.,
;;;   'rainbow-tag-names'
;;; and use the following with
;;;   x @delimiter
;;; deleted for x equal to any of "<", "</", ">" or "/>".

(element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter @sentinel)) @container

(element
  (self_closing_tag
    "<" @delimiter
    (tag_name) @delimiter
    "/>" @delimiter @sentinel)) @container

(element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter @_tag_name
    ">" @delimiter @sentinel)
  (#any-of? @_tag_name
   "area"
   "base"
   "br"
   "col"
   "embed"
   "hr"
   "img"
   "input"
   "link"
   "meta"
   "param"
   "source"
   "track"
   "wbr")
) @container

(style_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (element (self_closing_tag) @delimiter)*
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter @sentinel)) @container

(script_element
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter @sentinel)) @container
