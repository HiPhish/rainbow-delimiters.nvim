(command_substitution
  "$(" @delimiter
  ")"  @delimiter) @container

(expansion
  "${" @delimiter
  (":-" @delimiter)?
  "}" @delimiter) @container

;;; The double-bracket variant is a bashism
(test_command
  ["[[" "["] @delimiter
  ["]]" "]"] @delimiter) @container

(subshell
 "(" @delimiter
 ")" @delimiter) @container

(array
 "(" @delimiter
 ")" @delimiter) @container

(function_definition
 "(" @delimiter
 ")" @delimiter) @container

(arithmetic_expansion
 "$((" @delimiter
 "))" @delimiter) @container

(compound_statement
 "{" @delimiter
 "}" @delimiter) @container

(subscript
 "[" @delimiter
 "]" @delimiter) @container
