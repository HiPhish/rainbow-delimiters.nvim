(list
  "[" @opening
  "]" @closing) @container

(list_comprehension
  "[" @opening
  (for_in_clause
    ["for" "in"] @intermediate)
  "]" @closing) @container

(dictionary
  "{" @opening
  "}" @closing) @container

(dictionary_comprehension
  "{" @opening
  (for_in_clause
    ["for" "in"] @intermediate)
  "}" @closing) @container

(set
  "{" @opening
  "}" @closing) @container

(set_comprehension
  "{" @opening
  (for_in_clause
    ["for" "in"] @intermediate)
  "}" @closing) @container

(tuple
  "(" @opening
  ")" @closing) @container

(generator_expression
  "(" @opening
  (for_in_clause
    ["for" "in"] @intermediate)
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
