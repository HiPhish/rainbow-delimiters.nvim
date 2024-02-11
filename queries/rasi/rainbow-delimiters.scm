(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(environ_value
  "$" @delimiter
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(environ_value
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list_value
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(distance_calc
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(feature_query
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(reference_value
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(rgb_color
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(hsl_color
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(hwb_color
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(cmyk_color
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(url_image
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(gradient_image
  "(" @delimiter
  ")" @delimiter @sentinel) @container
