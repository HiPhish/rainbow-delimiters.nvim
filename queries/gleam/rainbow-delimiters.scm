; MyRecord(3)
(arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; fn main()
(function_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; fn foo(arg: fn(String) -> MyType)
(function_parameter_types
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; type Foo(arg)
(type_parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; fn foo(arg: Number(_))
; The part with `Number()`
(type_arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; type Foo {
;   Bar(Int) # this line
; }
(data_constructor_arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

;; MyRecord(..foo, bar:)
(record_update
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; case foo {
;   CustomType(_) -> "this line"
; }
(record_pattern_arguments
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; #(foo, bar)
(tuple
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; case foo {
;   #() -> "this line"
; }
(tuple_pattern
  "(" @delimiter
  ")" @delimiter @sentinel) @container

; fn foo(arg: #(_, _)) {
(tuple_type
"(" @delimiter
")" @delimiter @sentinel) @container

; let lst = []
(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

; case foo {
;   [] -> "here"
; }
(list_pattern
  "[" @delimiter
  "]" @delimiter @sentinel) @container

; let foo = { 2 + 2 }
(block
  "{" @delimiter
  "}" @delimiter @sentinel) @container

; case foo {}
(case
  "{" @delimiter
  "}" @delimiter @sentinel) @container

; type Foo {}
(type_definition
  "{" @delimiter
  "}" @delimiter @sentinel) @container

; import gleam/io.{println}
(unqualified_imports
  "{" @delimiter
  "}" @delimiter @sentinel) @container

; let foo = << >>
(bit_string
  "<<" @delimiter
  ">>" @delimiter @sentinel) @container

; case foo {
;   <<>> -> "here"
; }
(bit_string_pattern
  "<<" @delimiter
  ">>" @delimiter @sentinel) @container

; <<bar:bits-size(12)>>
(bit_string_segment_option
  "(" @delimiter
  ")" @delimiter @sentinel) @container
