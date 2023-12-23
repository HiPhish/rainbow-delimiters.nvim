(jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (identifier) @delimiter
              ">" @delimiter)
  close_tag: (jsx_closing_element
               "</" @delimiter
               name: (identifier) @delimiter
               ">" @delimiter @sentinel)) @container

(jsx_element
  open_tag: (jsx_opening_element
              "<" @delimiter
              name: (member_expression) @delimiter
              ">" @delimiter)
  close_tag: (jsx_closing_element
              "</" @delimiter
               name: (member_expression) @delimiter
              ">" @delimiter @sentinel)) @container

(jsx_self_closing_element
  "<" @delimiter
  name: (identifier) @delimiter
  "/>" @delimiter @sentinel) @container

(jsx_self_closing_element
  "<" @delimiter
  name: (member_expression) @delimiter
  "/>" @delimiter @sentinel) @container
