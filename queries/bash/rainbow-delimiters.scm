(command_substitution
  "$(" @delimiter
  ")"  @delimiter @sentinel) @container

(expansion
  "${" @delimiter
  (":-" @delimiter)?
  "}" @delimiter @sentinel) @container

;;; The double-bracket variant is a bashism
(test_command
  ["[[" "["] @delimiter
  ["]]" "]"] @delimiter @sentinel) @container

(subshell
 "(" @delimiter
 ")" @delimiter @sentinel) @container

(array
 "(" @delimiter
 ")" @delimiter @sentinel) @container

(function_definition
 "(" @delimiter
 ")" @delimiter @sentinel) @container

(arithmetic_expansion
 "$((" @delimiter
 "))" @delimiter @sentinel) @container

(compound_statement
 "{" @delimiter
 "}" @delimiter @sentinel) @container

(subscript
 "[" @delimiter
 "]" @delimiter @sentinel) @container
