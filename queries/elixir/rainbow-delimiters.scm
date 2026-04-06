(call
  (arguments
    "(" @delimiter
    ")" @delimiter) @container)

(block
  "(" @delimiter
  ")" @delimiter) @container

(string
  (interpolation
    "#{" @delimiter
    "}" @delimiter) @container)

(tuple
  "{" @delimiter
  "}" @delimiter) @container

(list
  "[" @delimiter
  "]" @delimiter) @container

(access_call
  "[" @delimiter
  "]" @delimiter) @container

(bitstring
  "<<" @delimiter
  ">>" @delimiter) @container

(map
  "%" @delimiter
  "{" @delimiter
  "}" @delimiter) @container
