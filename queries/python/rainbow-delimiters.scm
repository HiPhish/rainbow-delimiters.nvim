(list
  "[" @opening
  "]" @closing) @container

(list_comprehension
  "[" @opening
  "]" @closing) @container

(dictionary
  "{" @opening
  "}" @closing) @container

(dictionary_comprehension
  "{" @opening
  "}" @closing) @container

(set
  "{" @opening
  "}" @closing) @container

(set_comprehension
  "{" @opening
  "}" @closing) @container

(tuple
  "(" @opening
  ")" @closing) @container

(generator_expression
  "(" @opening
  ")" @closing) @container

(parameters
  "(" @opening
  ")" @closing) @container

(argument_list
  "(" @opening
  ")" @closing) @container

(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(subscript
  "[" @opening
  "]" @closing) @container
