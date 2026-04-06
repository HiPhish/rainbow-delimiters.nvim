(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(parameter_list
  "(" @delimiter
  ")" @delimiter) @container

(argument_list
  "(" @delimiter
  ")" @delimiter) @container

(for_parameters
  "(" @delimiter
  ")" @delimiter) @container

(for_in_loop
  "(" @delimiter
  ")" @delimiter) @container

(list
  "[" @delimiter
  "]" @delimiter) @container

(index
  "[" @delimiter
  "]" @delimiter) @container

(map
  "[" @delimiter
  "]" @delimiter) @container

(closure
  "{" @delimiter
  "}" @delimiter) @container

(switch_block
  "{" @delimiter
  "}" @delimiter) @container

(interpolation
  "{" @delimiter
  "}" @delimiter) @container

(string ; regex
  "/" @delimiter
  "/" @delimiter) @container

(generics
  "<" @delimiter
  ">" @delimiter) @container
