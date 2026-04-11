; let ... in
(let_expression ; Line 170
  (value_definition
    "let" @delimiter
    ("rec" @delimiter)?
    ("and" @delimiter (let_binding))*)
  "in" @delimiter) @container

(let_expression ; Line 256
  (value_definition
    (let_operator) @delimiter
    ((let_and_operator) @delimiter _)*)
  "in" @delimiter) @container

(let_expression ; Line 268
  "let" @delimiter
  (open_module)
  "in" @delimiter) @container

(let_expression ; Line 284
  "let" @delimiter
  (module_definition)
  "in" @delimiter) @container

(match_expression ; Line 182
  "match" @delimiter
  "with" @delimiter
  ("|" @delimiter
   (match_case
     (guard "when" @delimiter)?
     "->" @delimiter))+) @container

(function_expression ; Line 272
  "function" @delimiter
  ("|" @delimiter
   (match_case
     (guard "when" @delimiter)?
     "->" @delimiter))+) @container

; I can't get it to collapse else if into one
(if_expression ; Line 193
  "if" @delimiter
  (then_clause "then" @delimiter)
  (else_clause "else" @delimiter)*) @container

(for_expression ; Line 208
  "for" @delimiter
  "to" @delimiter
  (do_clause
    "do" @delimiter
    "done" @delimiter)) @container

(while_expression ; Line 219
  "while" @delimiter
  (do_clause
    "do" @delimiter
    "done" @delimiter)) @container

;;; Copied over from rainbow-delimiters

(array_get_expression ; Line 8
  "(" @delimiter
  ")" @delimiter) @container

(constructed_type ; Line 14
  "(" @delimiter
  ")" @delimiter) @container

(local_open_expression ; Line 27
  "(" @delimiter
  ")" @delimiter) @container

(module_parameter ; Line 38
  "(" @delimiter
  ")" @delimiter) @container

(package_expression ; Line 31
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_expression ; Line 6
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_module_expression ; Line 47
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_operator ; Line 25
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_pattern ; Line 23
  "(" @delimiter
  ")" @delimiter) @container

(parenthesized_type ; Line 12
  "(" @delimiter
  ")" @delimiter) @container

(object_expression ; Line 54
  "(" @delimiter
  ")" @delimiter) @container

(typed_pattern ; Line 18
  "(" @delimiter
  ")" @delimiter) @container

(typed_expression ; Line 50
  "(" @delimiter
  ")" @delimiter) @container

(list_expression ; Line 18
  "[" @delimiter
  "]" @delimiter) @container

(list_pattern ; Line 63
  "[" @delimiter
  "]" @delimiter) @container

(array_expression ; Line 68
  "[|" @delimiter
  "|]" @delimiter) @container

(array_pattern ; Line 73
  "[|" @delimiter
  "|]" @delimiter) @container

(attribute ; Line 84
  "[@" @delimiter
  "]" @delimiter) @container

(item_attribute ; Line 90
  "[@@" @delimiter
  "]" @delimiter) @container

(floating_attribute ; Line 93
  "[@@@" @delimiter
  "]" @delimiter) @container

(record_pattern ; Line 104
  "{" @delimiter
  "}" @delimiter) @container

(record_expression ; Line 99
  "{" @delimiter
  "}" @delimiter) @container

(record_declaration ; Line 96
  "{" @delimiter
  "}" @delimiter) @container

; Can't find an example
; (record_binding_pattern
;   "{" @delimiter
;   "}" @delimiter) @container

(class_binding ; Line 127
  "[" @delimiter
  "]" @delimiter) @container

(polymorphic_variant_type ; Line 244
  "[" @delimiter
  "]" @delimiter) @container

(polymorphic_variant_type ; Line 130
  "[<" @delimiter
  "]" @delimiter) @container

(polymorphic_variant_type ; Line 137
  "[>" @delimiter
  "]" @delimiter) @container

(string_get_expression ; Line 77
  "[" @delimiter
  "]" @delimiter) @container

(extension ; Line 140
  "[%" @delimiter
  "]" @delimiter) @container

(item_extension ; Line 147
  "[%%" @delimiter 
  "]" @delimiter) @container

(quoted_item_extension ; Line 150
  "{%%" @delimiter
  "}" @delimiter) @container

(quoted_string ; Line 81
  "{" @delimiter
  "}") @container

(bigarray_get_expression ; Line 158
  "{" @delimiter
  "}" @delimiter) @container

(object_copy_expression ; Line 166
  "{<" @delimiter
  ">}" @delimiter) @container

(packed_module ; Line 242
  "(" @delimiter
  ")" @delimiter) @container

(abstract_type ; Line 248
  "(" @delimiter
  ")" @delimiter) @container

(type_binding ; Line 276
  "(" @delimiter
  ")" @delimiter) @container

(parameter ; Line 252
  ("?" @delimiter)?
  ("~" @delimiter)?
  "(" @delimiter
  ")" @delimiter) @container

(package_pattern ; Line 278
  "(" @delimiter
  ")" @delimiter) @container
