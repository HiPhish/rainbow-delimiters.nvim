(array_get_expression ; Line 8
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(coercion_expression ; Line 122
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(constructed_type ; Line 14
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(local_open_expression ; Line 27
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(module_parameter ; Line 38
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(package_expression ; Line 31
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression ; Line 6
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_module_expression ; Line 47
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_operator ; Line 25
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_pattern ; Line 23
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_type ; Line 12
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(object_expression ; Line 54
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(typed_pattern ; Line 18
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(typed_expression ; Line 50
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list_expression ; Line 18
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(list_pattern ; Line 63
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(array_expression ; Line 68
  "[|" @delimiter
  "|]" @delimiter @sentinel) @container

(array_pattern ; Line 73
  "[|" @delimiter
  "|]" @delimiter @sentinel) @container

(attribute ; Line 84
  "[@" @delimiter
  "]" @delimiter @sentinel) @container

(item_attribute ; Line 90
  "[@@" @delimiter
  "]" @delimiter @sentinel) @container

(floating_attribute ; Line 93
  "[@@@" @delimiter
  "]" @delimiter @sentinel) @container

(record_pattern ; Line 104
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(record_expression ; Line 99
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(record_declaration ; Line 96
  "{" @delimiter
  "}" @delimiter @sentinel) @container

; Can't find an example
; (record_binding_pattern
;   "{" @delimiter
;   "}" @delimiter @sentinel) @container

(class_binding ; Line 127
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(polymorphic_variant_type ; Line 244
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(polymorphic_variant_type ; Line 130
  "[<" @delimiter
  "]" @delimiter @sentinel) @container

(polymorphic_variant_type ; Line 137
  "[>" @delimiter
  "]" @delimiter @sentinel) @container

(string_get_expression ; Line 77
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(extension ; Line 140
  "[%" @delimiter
  "]" @delimiter @sentinel) @container

(item_extension ; Line 147
  "[%%" @delimiter 
  "]" @delimiter @sentinel) @container

(quoted_item_extension ; Line 150
  "{%%" @delimiter
  "}" @delimiter @sentinel) @container

(quoted_string ; Line 81
  "{" @delimiter
  "}" @sentinel) @container

(bigarray_get_expression ; Line 158
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(object_copy_expression ; Line 166
  "{<" @delimiter
  ">}" @delimiter @sentinel) @container

(packed_module ; Line 242
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(abstract_type ; Line 248
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(type_binding ; Line 276
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameter; Line 252
  ("?" @delimiter)?
  ("~" @delimiter)?
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(package_pattern ; Line 278
  "(" @delimiter
  ")" @delimiter @sentinel) @container
