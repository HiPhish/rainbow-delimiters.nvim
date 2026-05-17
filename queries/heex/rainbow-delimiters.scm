(tag
  (start_tag
    "<" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)
  (end_tag
    "</" @delimiter
    (tag_name) @delimiter
    ">" @delimiter)) @container

(tag
  (self_closing_tag
    "<" @delimiter
    (tag_name) @delimiter
    "/>" @delimiter)) @container

(component
  (start_component
    "<" @delimiter
    (component_name) @delimiter
    ">" @delimiter)
  (end_component
    "</" @delimiter
    (component_name) @delimiter
    ">" @delimiter)) @container

(component
  (self_closing_component
    "<" @delimiter
    (component_name) @delimiter
    "/>" @delimiter)) @container

(slot
  (start_slot
    "<:" @delimiter
    (slot_name) @delimiter
    ">" @delimiter)
  (end_slot
    "</:" @delimiter
    (slot_name) @delimiter
    ">" @delimiter)) @container

