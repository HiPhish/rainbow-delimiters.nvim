import gleam/io.{println} // unqualified_imports

pub fn main()
{ // block
    println("Hi!")
}

pub type Cobel // type_definition
(name, age) { // type_parameters
    Cobel(name: Int, age: Int) // data_constructor_arguments
}

pub type Helly {
    Helly(real_one: Bool)
    Helena(real_one: Bool)
}


pub fn check_hair(tup: #(String, String)) { // tuple_type
    let hellys = #("Helly", "Helena")  // tuple
    case tup {
        #("Orange", "Hair") -> hellys // tuple_pattern
        _ -> #("Mark S.", "Mark Scout")
    }
}

pub fn is_irving_first() {
    let lst = ["Mark", "Helly", "Dylan", "Irving"] // list
    case lst {
        ["Irving", ..] -> True // list_pattern
        [_, ..] -> False
        [] -> False
    }
}

// Couldn't think of a severance reference for a bit string. Forgive me!
pub fn bit_string_empty() {
    let var = <<3:size(8)>> // bit_string_segment_option
    case var {
        <<>> -> True // bit_string_pattern
        _ -> False
    }
}

pub fn operate_on_hello(func: fn(String) -> a) { // function_parameter_types
    func("hello") // arguments
}

pub fn change_cobel_age(arg: Cobel(_, _)) { // type_arguments
    Cobel(..arg, age:13) // record_update
}

pub fn which_helly(my_helly) { // function_parameters
    case my_helly { // case
        Helly(_) -> "the numbers were scary" // record_pattern_arguments
        Helena(_) -> "i'm like the head of the company"
    }
}
