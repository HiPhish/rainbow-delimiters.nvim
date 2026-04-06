(tuple
  (tuple_start "[") @delimiter
  (tuple_end   "]") @delimiter) @container

(for_tuple_expr
  (tuple_start "[") @delimiter
  (tuple_end   "]") @delimiter) @container

(new_index
  "[" @delimiter
  "]" @delimiter) @container

(function_call
   "(" @delimiter
   ")" @delimiter) @container

(expression
  "(" @delimiter
  ")" @delimiter) @container

(binary_operation
  "(" @delimiter
  ")" @delimiter) @container

(unary_operation
  "(" @delimiter
  ")" @delimiter) @container

(block
  (block_start "{") @delimiter
  (block_end   "}") @delimiter) @container

(object
  (object_start "{") @delimiter
  (object_end   "}") @delimiter) @container

(for_object_expr
  (object_start "{") @delimiter
  (object_end   "}") @delimiter) @container

(template_interpolation
  (template_interpolation_start) @delimiter
  (template_interpolation_end) @delimiter) @container

(_
  (template_directive_start) @delimiter
  (template_directive_end) @delimiter) @container
