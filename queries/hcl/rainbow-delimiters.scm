(tuple
  (tuple_start "[") @opening
  (tuple_end   "]") @closing) @container

(function_call
   "(" @opening
   ")" @closing) @container

(block
  (block_start "{") @opening
  (block_end   "}") @closing) @container

(object
  (object_start "{") @opening
  (object_end   "}") @closing) @container
