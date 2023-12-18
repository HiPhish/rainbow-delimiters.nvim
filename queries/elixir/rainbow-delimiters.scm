(call
  (arguments
    "(" @delimiter
    ")" @delimiter @sentinel) @container)

(block
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(string
  (interpolation
    "#{" @delimiter
    "}" @delimiter @sentinel) @container)

(tuple
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(access_call
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(bitstring
  "<<" @delimiter
  ">>" @delimiter @sentinel) @container

(map
  "%" @delimiter
  "{" @delimiter
  "}" @delimiter @sentinel) @container
