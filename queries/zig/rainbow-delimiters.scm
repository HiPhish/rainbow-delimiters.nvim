(parameters
   "(" @delimiter
   ")" @delimiter) @container

(arguments
   "(" @delimiter
   ")" @delimiter) @container

(if_statement
   "(" @delimiter
   ")" @delimiter) @container

(if_expression
  "(" @delimiter
  ")" @delimiter) @container

(if_type_expression
  "(" @delimiter
  ")" @delimiter) @container

(for_statement
   "(" @delimiter
   ")" @delimiter) @container

(for_expression
  "(" @delimiter
  ")" @delimiter) @container

(while_statement
  "(" @delimiter
  .
  condition: (_)
  .
  ")" @delimiter
  (
    ":" @delimiter
    "(" @delimiter
    ")" @delimiter
  )?
) @container

(while_expression
  "(" @delimiter
  .
  condition: (_)
  .
  ")" @delimiter
  (
  ":" @delimiter
  "(" @delimiter
  ")" @delimiter
  )?
) @container

(link_section
   "(" @delimiter
   ")" @delimiter) @container

(calling_convention
   "(" @delimiter
   ")" @delimiter) @container

(asm_expression
   "(" @delimiter
   ")" @delimiter) @container

(asm_input_item
   "[" @delimiter
   "]" @delimiter
   "(" @delimiter
   ")" @delimiter) @container

(asm_output_item
   "[" @delimiter
   "]" @delimiter
   "(" @delimiter
   ")" @delimiter) @container

(switch_expression
   "(" @delimiter
   ")" @delimiter
   "{" @delimiter
   ((switch_case
     "=>" @delimiter)
   _)+
   "}" @delimiter) @container

(array_type
   "[" @delimiter
   "]" @delimiter) @container

(slice_type
   "[" @delimiter
   "]" @delimiter) @container

(index_expression
   "[" @delimiter
   "]" @delimiter) @container

(pointer_type
  (
    "(" @delimiter
    ")" @delimiter
  )?
  (
    "[" @delimiter
    "]" @delimiter
  )?
) @container

(block
   "{" @delimiter
   "}" @delimiter) @container

(initializer_list
   "{" @delimiter
   "}" @delimiter) @container

(payload
  .  ;; Without the anchor the @delimiter will be matched three times
  "|" @delimiter
  "|" @delimiter) @container

(opaque_declaration
  "{" @delimiter
  "}" @delimiter) @container

(struct_declaration
  (
    "(" @delimiter
    ")" @delimiter
  )?
  "{" @delimiter
  "}" @delimiter) @container

(enum_declaration
  (
    "(" @delimiter
    ")" @delimiter
  )?
  "{" @delimiter
  "}" @delimiter) @container

(union_declaration
  (
    "(" @delimiter
    ")" @delimiter
  )?
  "{" @delimiter
  "}" @delimiter) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter) @container

(error_set_declaration
  "{" @delimiter
  "}" @delimiter) @container

(byte_alignment
  "(" @delimiter
  ")" @delimiter) @container

(address_space
  "(" @delimiter
  ")" @delimiter) @container
