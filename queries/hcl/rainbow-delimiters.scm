(tuple
  (tuple_start "[") @delimiter
  (tuple_end   "]") @delimiter @sentinel) @container

(function_call
   "(" @delimiter
   ")" @delimiter @sentinel) @container

(block
  (block_start "{") @delimiter
  (block_end   "}") @delimiter @sentinel) @container

(object
  (object_start "{") @delimiter
  (object_end   "}") @delimiter @sentinel) @container
