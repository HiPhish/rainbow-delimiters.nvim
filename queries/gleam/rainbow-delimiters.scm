; MyRecord(3)
(arguments
  "(" @delimiter
  ")" @delimiter) @container

; fn main()
(function_parameters
  "(" @delimiter
  ")" @delimiter) @container

; fn foo(arg: fn(String) -> MyType)
(function_parameter_types
  "(" @delimiter
  ")" @delimiter) @container

; type Foo(arg)
(type_parameters
  "(" @delimiter
  ")" @delimiter) @container

; fn foo(arg: Number(_))
; The part with `Number()`
(type_arguments
  "(" @delimiter
  ")" @delimiter) @container

; type Foo {
;   Bar(Int) # this line
; }
(data_constructor_arguments
  "(" @delimiter
  ")" @delimiter) @container

;; MyRecord(..foo, bar:)
(record_update
  "(" @delimiter
  ")" @delimiter) @container

; case foo {
;   CustomType(_) -> "this line"
; }
(record_pattern_arguments
  "(" @delimiter
  ")" @delimiter) @container

; #(foo, bar)
(tuple
  "(" @delimiter
  ")" @delimiter) @container

; case foo {
;   #() -> "this line"
; }
(tuple_pattern
  "(" @delimiter
  ")" @delimiter) @container

; fn foo(arg: #(_, _)) {
(tuple_type
"(" @delimiter
")" @delimiter) @container

; let lst = []
(list
  "[" @delimiter
  "]" @delimiter) @container

; case foo {
;   [] -> "here"
; }
(list_pattern
  "[" @delimiter
  "]" @delimiter) @container

; let foo = { 2 + 2 }
(block
  "{" @delimiter
  "}" @delimiter) @container

; case foo {}
(case
  "{" @delimiter
  "}" @delimiter) @container

; type Foo {}
(type_definition
  "{" @delimiter
  "}" @delimiter) @container

; import gleam/io.{println}
(unqualified_imports
  "{" @delimiter
  "}" @delimiter) @container

; let foo = << >>
(bit_array
  "<<" @delimiter
  ">>" @delimiter) @container

; case foo {
;   <<>> -> "here"
; }
(bit_array_pattern
  "<<" @delimiter
  ">>" @delimiter) @container

; <<bar:bits-size(12)>>
(bit_array_segment_option
  "(" @delimiter
  ")" @delimiter) @container
