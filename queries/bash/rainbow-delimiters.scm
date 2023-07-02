(command_substitution
  "$(" @opening
  ")"  @closing) @container

(expansion
  "${" @opening
  (":-" @intermediate)?
  "}" @closing) @container

;;; The double-bracket variant is a bashism
(test_command
  ["[[" "["] @opening
  ["]]" "]"] @closing) @container

(subshell
 "(" @opening
 ")" @closing) @container
