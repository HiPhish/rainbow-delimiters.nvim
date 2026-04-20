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

(do_block
  "do" @delimiter
  "end" @delimiter) @container

(call
  target: (identifier) @name @delimiter
  (#any-of? @name "defmodule" "def" "defp" "defmacro" "quote")
  (arguments)?
  (do_block
    "do" @delimiter
    "end" @delimiter
  )
) @container

(call
 target: (identifier) @name @delimiter (#eq? @name "with")
  (arguments
    [(binary_operator
      "<-" @delimiter) ("," @delimiter) _]+)
  (do_block
    "do" @delimiter
    (else_block
      "else" @delimiter
      (stab_clause
        "->" @delimiter
      )*
    )?
    "end" @delimiter  )
) @container

(anonymous_function
  "fn" @delimiter
  (stab_clause
    "->" @delimiter
  )*
  "end" @delimiter) @container

(call
  target: (identifier) @name @delimiter
  (#any-of? @name "if" "unless")
  (arguments)
  (do_block
    "do" @delimiter
    (else_block
      "else" @delimiter
    )?
    "end" @delimiter
  )
) @container

(call
  target: (identifier) @name @delimiter
  (#any-of? @name "case" "cond")
  (arguments)?
  (do_block
    "do" @delimiter
    (stab_clause
      "->" @delimiter
    )*
    "end" @delimiter
  )
) @container

(call
  target: (identifier) @name @delimiter (#eq? @name "for")
  (arguments
    [(binary_operator
      "<-" @delimiter) _]+)
  (do_block
    "do" @delimiter
    "end" @delimiter  )
) @container

(call
  target: (identifier) @name @delimiter (#eq? @name "receive")
  (do_block
    "do" @delimiter
    (stab_clause
      "->" @delimiter
    )*
    (after_block
      "after" @delimiter
      (stab_clause
        "->" @delimiter
      )*
    )?
    "end" @delimiter  )
) @container

(call
  target: (identifier) @name @delimiter (#eq? @name "try")
  (do_block
    "do" @delimiter
    (rescue_block
      "rescue" @delimiter
      (stab_clause
        "->" @delimiter
      )*
    )?
    (catch_block
      "catch" @delimiter
      (stab_clause
        "->" @delimiter
      )*
    )?
    (after_block
      "after" @delimiter
    )?
    "end" @delimiter  )
) @container


