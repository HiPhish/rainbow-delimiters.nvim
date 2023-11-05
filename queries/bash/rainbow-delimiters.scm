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
