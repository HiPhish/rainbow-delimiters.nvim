; ─── Disabled due to being unable to match more than one argument at a time ───
;
;(argument_patterns
;  ("(" @opening ")" @closing)+
;  ) @container
;
;(record_type_defn
;  "{" @opening
;  "}" @closing
;  ) @container
;
;(type_arguments
;  "<" @opening
;  ">" @closing
;  ) @container
;

; highlight unit expressions in function applications 
; and return types for consistency
(application_expression
  (const 
    (unit
      "(" @opening
      ")" @closing
    )) @container
  )

(return_expression
  (const 
    (unit
      "(" @opening
      ")" @closing
    )) @container
  )

(if_expression
  (const 
    (unit
      "(" @opening
      ")" @closing
    )) @container
  )

(method_or_prop_defn
  (const 
    (unit
      "(" @opening
      ")" @closing
    )) @container
 )

(function_or_value_defn 
  body: (const 
    (unit
      "(" @opening
      ")" @closing
    )) @container
 )

(paren_expression
  "(" @opening
  ")" @closing
  ) @container

(paren_pattern
  "(" @opening
  ")" @closing
  ) @container

(type
  "(" @opening
  ")" @closing
  ) @container

(type
  "<" @opening
  ">" @closing
  ) @container


(list_pattern
  "[" @opening
  "]" @closing
  ) @container

(array_pattern
  "[|" @opening
  "|]" @closing
  ) @container

(ce_expression
  [ (return_expression (long_identifier_or_op (long_identifier)))
    (long_identifier_or_op (long_identifier))
  ] @intermediate

  "{" @opening
  "}" @closing
  ) @container
