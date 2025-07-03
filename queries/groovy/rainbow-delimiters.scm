(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameter_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(for_in_loop
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(index
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(map
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(closure
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(switch_block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(interpolation
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(string ; regex
  "/" @delimiter
  "/" @delimiter @sentinel) @container

(generics
  "<" @delimiter
  ">" @delimiter @sentinel) @container
