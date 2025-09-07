module Regular

let no_args () =
    ()

let one_arg (x: int) =
    x

let two_args (x: int) (y: int) =
    x + y

let three_args (x: int) (y: int) (z: int) =
    x + y + z

let tuple ( (x: (int * float)) ) =
    x

let destructured_tuple ((a, b): int * int) =
    a + b

let array (x: int array) = function
    | [|x|] -> x
    | [| x; y; z |] -> x + y + x
    | _ -> 0

let nested_array (x: int array array) = function
    | [| [| [| x |] |] |] -> x
    | [| [| [| x; y; z |] |] |] -> x + y + z
    | _ -> 0

let list (x: int list) = function
    | [x] -> x
    | [ x; y; z ] -> x + y + x
    | _ -> 0

let nested_list (x: int list list) = function
    | [ [ [ x ] ] ] -> x
    | [ [ [ x; y; z ] ] ] -> x + y + x
    | _ -> 0

let return_value =
    (Some (Ok (Some (2))))

let type_argument (x: seq<'a>) =
    x

let nested_type_argument (x: seq<seq<seq<int>>>) =
    x

type Record =
    { a: int
      b: string
    }

type Union =
    | Tuple of (int * float)
    | NestedTuple of (int * (int * (int * int)))
    | TypeArgs of Result<seq<int>, float>

type Wrapper = Wrapper of int * int

let unwrap (Wrapper (a, b)) =
    a + b

let lambda =
    (fun x -> (fun (a, b) -> x))

let match_test x =
    match x with
    | (Some (((((Some (a))))))) -> a
    | _ -> 0

let unit_args () () () = 
    ()

let computation_expressions asyncFn (x: int) =
    async {
        let t = 
            task {
                let a = 2
                let b = 3
                return async {
                    let! res = asyncFn (x)
                    return res + a + b
                }
            }
        return t
    }

let if_tests (x: int) =
    if x <> 0 then
        ()
    elif x < 1 then
        ()
    else 
        ()


type Class(a: int) =
    member _.A () = 
        (a)

    member this.Member () = 
        ()

    static member StaticMember () = 
        ()

let main _ =
    unit_args () ((((((((((())))))))))) ();
    one_arg ((((((((((((1)))))))))))) |> ignore;
    two_args (1) (((((((((2))))))))) |> ignore;
