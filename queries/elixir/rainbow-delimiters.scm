(call
  (arguments
    "(" @opening
    ")" @closing) @container)

(block
  "(" @opening
  ")" @closing) @container

;; This pattern breaks the parser.
; Error attaching strategy to buffer 1: /usr/share/nvim/runtime/lua/vim/treesitter/query.lua:259: query: invalid structure at position 170 for language elixir
(string
  (interpolation
    "#{" @opening
    "}" @closing) @container)

(tuple
  "{" @opening
  "}" @closing) @container

(list
  "[" @opening
  "]" @closing) @container

(bitstring
  "<<" @opening
  ">>" @closing) @container

(map
  "{" @opening
  "}" @closing) @container
