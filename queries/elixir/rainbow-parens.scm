; inherits: square,round,curly
(bitstring
  "<<" @left
  ">>" @right)
(map
  "%" @left
  "{" @left
  "}" @right)
(interpolation
  "#{" @left
  "}" @right)
(sigil
  (sigil_name) @left
  (sigil_modifiers) @right)
