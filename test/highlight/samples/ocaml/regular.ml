open! Base
open! Stdio

let () =
  (* parenthesized_expression *)
  let arr = Array.init 10 ~f:(fun _ -> 0) in
  (* array_get_expression *)
  printf "%d" arr.(0)
;;

(* parenthesized_type *)
type t = A of (int64 * (string * char))

(* constructed_type *)
type s = (int * string) list

(* typed_pattern, list expression *)
let (a : s) = [ 1, "1" ]

(* parameter *)
let print_t (x : t) : unit =
  (* parenthesized_pattern *)
  let (A (a, (b, c))) = x in
  (* parenthesized_operator *)
  let a' = Int64.( + ) a a in
  (* local_open_expression *)
  printf "%d %s %c" Int.(of_int64_exn a') b c
;;

(* package_expression *)
let table = Hashtbl.create (module Int)

module type S = sig
  val x : int
end

(* module parameter *)
module Dbl (T : S) : S = struct
  let x = T.x * 2
end

module X1 = struct
  let x = 0
end

(* parenthesized_module_expression *)
module X2 = Dbl (X1)

(* typed expression *)
let x = (3 : int)

let sq (x : int) =
  (* object_expression *)
  object (self)
    val l = x
    method getl = self#getl + 1
  end
;;

let is_empty (x : s) =
  match x with
  (* list_pattern *)
  | [] -> true
  | _ :: _ -> false
;;

(* array_expression *)
let a' = [| 1, "1" |]

let is_empty_or_cond (x : (int * string) array) =
  match x with
  (* array_pattern *)
  | [||] -> true
  | _ ->
    let x' = snd x.(0) in
    (* string_get_expression *)
    Char.is_alphanum x'.[0]
;;

(* quoted_string *)
let big_string = {| owo |}

(* attribute *)
let x = (3 [@owo])

module X = struct
  let x = 3
end
(* item_attribute *)
[@@owo]

(* floating_attribute *)
[@@@text owo]

(* record_declaration *)
type x = { s : int list }

(* record_expression *)
let empty : x = { s = [] }

let is_empty (t : x) =
  match t with
  (* record_pattern *)
  | { s = [] } -> true
  | _ -> false
;;

(* From https://dev.realworldocaml.org/objects.html *)
type shape = < area : float >
type square = < area : float ; width : int >

let square w =
  object
    method area = Float.of_int (w * w)
    method width = w
  end
;;

let squares : square list = [ square 10; square 20 ]

(* coercion_expression *)
let shapes : shape list = (squares :> shape list)

type x = { s : int list }

(* class_binding *)
class ['a] istack = object end

(* polymorphic_variant_type, covariant *)
let poly2 (x : [< `One | `Two of int ]) =
  match x with
  | `One -> 1
  | `Two _ -> 2
;;

(* polymorphic_variant_type, contravariant *)
let poly1 x : [> `One | `Two of int ] = if x = 1 then `One else `Two x

(* extension *)
let () = print_s @@ [%sexp_of: int] 3

(* item_extension *)
module type X = sig
  val x : int
end

[%%owo]

(* quoted_item_extension *)
{%%owo|owo|}

let a =
  let open Bigarray in
  Array1.init Int C_layout 100 (fun _ -> 1)
;;

(* bigarray_get_expression *)
let () = printf "%d" a.{0}

let st =
  object
    val v = 1

    method add =
      (* object_copy_expression *)
      {<v = v + 1>}
  end
;;

(* let ... in *)
let x =
  let a =
    let b =
      let c = 3 in
      c + 1
    in
    b + 1
  in
  a + 1
;;

(* match_expression *)
let f x =
  match x with
  | [] -> 0
  | [ x ] when some_check x ->
    (match x with
     | `One -> 1
     | `Two _ -> 2)
  | _ -> -1
;;

(* if_expression *)
let g x =
  if x < 0
  then -1
  else if x = 0
  then 0
  else if x = 1
  then 1
  else if x = 2
  then 2
  else if x = 3
  then 3
  else 4
;;

(* for_expression *)
for i = 0 to 2 do
  for j = 0 to 2 do
    for k = 0 to 2 do
      for l = 0 to 2 do
        printf "%d %d %d %d\n" i j k l
      done
    done
  done
done

(* while_expression *)
let () =
  let i = ref 0 in
  let j = ref 0 in
  let k = ref 0 in
  let l = ref 0 in
  while !i < 3 do
    while !j < 3 do
      while !k < 3 do
        while !l < 3 do
          printf "%d %d %d %d\n" !i !j !k !l;
          i := !i + 1;
          j := !j + 1;
          k := !k + 1;
          l := !l + 1
        done
      done
    done
  done
;;


(* packed_module *)
module Test = (val M.test)

(* polymorphic_variant_type *)
let poly3 x : [ `Natural of int | `Complex of (int * int) ] = `Natural 1

(* abstract_type *)
let pp_ctyp_prim (type a) ppf : a Ctypes_primitive_types.prim -> unit =
  fun t -> ()

(* parameter *)
let fun_with_param ~(param: 'a param) = ()
let fun_with_param ?(param = "") = Fmt.pr "param: %s" param

(* let_expression *)
let () =
  let+ x = 10
  and* y = 29
  and+ z =
    let m = 100
    and n = 0
    and o = x
    in o
  in 
  let rec aux i x =
    if i = 1 then x else aux (i-1) (x*y)
  in aux z
  z
;;

(* let_open_expression *)
let () =
  let open Option in
  ()

let function_expression = function
  | x::xs when x > 10 -> true
  | _ -> false

type ('raw_test) data = { field : string }

let fn (module P: SOME_MODULE) = ()

let () =
  let module Opt = Option in
  ()
