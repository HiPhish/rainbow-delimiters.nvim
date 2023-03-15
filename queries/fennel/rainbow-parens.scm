(list
  "(" @opening
  ")" @closing) @container

(table
  "{" @opening
  (":" @intermediate)?
  "}" @closing) @container

(sequential_table
  "[" @opening
  "]" @closing) @container

(fn
  "(" @opening
   ")" @closing) @container

(lambda
  "(" @opening
   ")" @closing) @container

(let
  "(" @opening
  ")" @closing) @container

(set
  "(" @opening
  ")" @closing) @container

(each
  "(" @opening
  ")" @closing) @container

(for
  "(" @opening
  ")" @closing) @container

(icollect
  "(" @opening
  ")" @closing) @container

(collect
  "(" @opening
  ")" @closing) @container

(accumulate
  "(" @opening
  ")" @closing) @container
