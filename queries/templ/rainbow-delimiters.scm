; inherits: go

(rawgo_block
  "{{" @delimiter
  "}}" @delimiter @sentinel) @container

;; HTML elements

(element
  (tag_start
    "<" @delimiter
    (element_identifier) @delimiter
    ">" @delimiter)
  (tag_end
    "</" @delimiter
    (element_identifier) @delimiter
    ">" @delimiter @sentinel)) @container

(element
  (self_closing_tag
    "<" @delimiter
    (element_identifier) @delimiter
    "/>" @delimiter @sentinel)) @container

(style_element
  (style_tag_start
    "<" @delimiter
    "style" @delimiter
    ">" @delimiter)
  (style_tag_end
    "</" @delimiter
    "style" @delimiter
    ">" @delimiter)) @container

(script_element
  (script_tag_start
    "<" @delimiter
    "script" @delimiter
    ">" @delimiter)
  (script_tag_end
    "</" @delimiter
    "script" @delimiter
    ">" @delimiter)) @container

;; Brackets

(component_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(script_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(css_declaration
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(component_switch_statement
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(component_children_expression
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(expression
  "{" @delimiter
  "}" @delimiter @sentinel) @container
