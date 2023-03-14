(element
  ((start_tag
      ["<" ">"] @opening)
   (element
      (self_closing_tag
        ["<" "/>"] @intermediate))?
   (end_tag
      ["</" ">"] @closing))) @container

(template_element
  ((start_tag
      ["<" ">"] @opening)
   (element
      (self_closing_tag
        ["<" "/>"] @intermediate))?
   (end_tag
      ["</" ">"] @closing))) @container

(script_element
  ((start_tag
      ["<" ">"] @opening)
   (element
      (self_closing_tag
        ["<" "/>"] @intermediate))?
   (end_tag
      ["</" ">"] @closing))) @container

(style_element
  ((start_tag
      ["<" ">"] @opening)
   (element
      (self_closing_tag
        ["<" "/>"] @intermediate))?
   (end_tag
      ["</" ">"] @closing))) @container
