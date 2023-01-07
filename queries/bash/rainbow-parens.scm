; inherits: round,curly,square
(_
  "[[" @left
  "]]" @right)
(command_substitution
  "$(" @left
  ")" @right)
(expansion
  "${" @left
  "}" @right)
