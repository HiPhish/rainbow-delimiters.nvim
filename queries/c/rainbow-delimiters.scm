(parameter_list
   "(" @opening
   ")" @closing) @container

(argument_list
   "(" @opening
   ")" @closing) @container

(parenthesized_expression
  "(" @opening
  ")" @closing) @container

(compound_statement
  "{" @opening
  "}" @closing) @container

(initializer_list
  "{" @opening
  "}" @closing) @container

(subscript_expression
  "[" @opening
  "]" @closing) @container

(field_declaration_list
   "{" @opening
   "}" @closing) @container

;;; We could also add type casts, but those are not nested, so I don't think
;;; they belong here.
