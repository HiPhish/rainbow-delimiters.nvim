(tuple
  (tuple_start "[") @delimiter
  (tuple_end   "]") @delimiter @sentinel) @container

(for_tuple_expr
  (tuple_start "[") @delimiter
  (tuple_end   "]") @delimiter @sentinel) @container

(new_index
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(function_call
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(binary_operation
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(unary_operation
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(block
  (block_start "{") @delimiter
  (block_end   "}") @delimiter @sentinel) @container

(object
  (object_start "{") @delimiter
  (object_end   "}") @delimiter @sentinel) @container

(for_object_expr
  (object_start "{") @delimiter
  (object_end   "}") @delimiter @sentinel) @container

(template_interpolation
  (template_interpolation_start) @delimiter
  (template_interpolation_end) @delimiter @sentinel) @container

(_
  (template_directive_start) @delimiter
  (template_directive_end) @delimiter @sentinel) @container
