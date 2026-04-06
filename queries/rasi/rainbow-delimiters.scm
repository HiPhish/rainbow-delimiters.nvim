(block
  "{" @delimiter
  "}" @delimiter) @container

(environ_value
  "$" @delimiter
  "{" @delimiter
  "}" @delimiter) @container

(environ_value
  "(" @delimiter
  ")" @delimiter) @container

(list_value
  "[" @delimiter
  "]" @delimiter) @container

(distance_calc
  "(" @delimiter
  ")" @delimiter) @container

(feature_query
  "(" @delimiter
  ")" @delimiter) @container

(reference_value
  "(" @delimiter
  ")" @delimiter) @container

(rgb_color
  "(" @delimiter
  ")" @delimiter) @container

(hsl_color
  "(" @delimiter
  ")" @delimiter) @container

(hwb_color
  "(" @delimiter
  ")" @delimiter) @container

(cmyk_color
  "(" @delimiter
  ")" @delimiter) @container

(url_image
  "(" @delimiter
  ")" @delimiter) @container

(gradient_image
  "(" @delimiter
  ")" @delimiter) @container
