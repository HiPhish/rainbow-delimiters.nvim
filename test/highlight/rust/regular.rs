#![crate_type = "lib"]
struct NestedStruct {
    value: u32,
    inner: Inner,
}

struct Inner {
    value: u32,
}

extern "C" {
    fn extern_block();
}

union TestUnion {
    val_1: f32,
    val_2: u32,
}

#[derive(Default, Debug)]
struct TupleStruct(u32);

#[cfg_attr(all(target_os = "linux", feature = "multithreaded"), derive(Default))]
enum EnumTest {
    TupleVariant(u32),
    TupleVariantTupleStruct(TupleStruct),
    StructVariant { value: u32 },
    NestedStructVariant { inner: Inner },
}

fn test_type_param<A: Default>() -> usize {
    std::mem::size_of::<A>()
}

fn test_param(a: u32, b: u32) -> u32 {
    a * b
}

fn tuple_param(a: (u32, u32)) -> u32 {
    let (a, b) = a;

    a * a
}

macro_rules! inefficient_vec {
    ( $( $x:expr ),* ) => {
        {
            let mut temp_vec = Vec::new();
            $(
                temp_vec.push($x);
            )*
            temp_vec
        }
    };
}

pub(crate) struct VisibilityModifier;


pub const NAMES: &'static [(&'static str, u32)] = &[
    ("TEST NAME 1", 1),
    ("TEST NAME 2", 2),
];

fn main() {
    let nested_vec: Vec<Vec<Vec<Vec<Vec<Vec<()>>>>>> = Vec::<_>::new();
    let arr_arr_arr = [[[0; 4]; 4]; 4];
    let constructed_struct = Inner { value: 0 };

    let nested_constructed = NestedStruct {
        value: 0,
        inner: Inner { value: 0 },
    };

    let tuple_struct = TupleStruct(0);
    let nested_tuple = (
        ((1, 2, 3, 4), (5, 6, 7, 8)),
        ((9, 10, 11, 12), (13, 14, 15, 16)),
    );

    let enums = vec![
        EnumTest::TupleVariant(0),
        EnumTest::TupleVariantTupleStruct(TupleStruct(0)),
        EnumTest::StructVariant { value: 0 },
        EnumTest::NestedStructVariant {
            inner: Inner { value: 0 },
        },
    ];

    let closure = |long_parameter_name: u8,
                   long_parameter_name_two: u8,
                   very_long_parameter_name: u8,
                   extra_long_name: u8| {
        let nested_closure = || {};
        nested_closure();
    };

    let async_block = async { 0 };

    let labelled_block = 'a: { 0 };

    let boolean_expr = (((3 * 4) + 5) > 1 || false) && (true || true);

    let num = 5;

    let match_expr = match num {
        _ => match boolean_expr {
            _ => {}
        },
    };

    let fancy_match_expr = match enums[0] {
        EnumTest::TupleVariant(v) => {}
        EnumTest::TupleVariantTupleStruct(TupleStruct(v)) => {}
        EnumTest::StructVariant { value } => {}
        EnumTest::NestedStructVariant {
            inner: Inner { value },
        } => {}
    };

    let array = [1, 2, 3, 4];

    let array_match = match array {
        [a, b, c, d] => {}
    };

    let nested_macro = vec![vec![vec![vec![vec![0]]]]];

    test_param(3, 4);

    let test_tuple: (u32, u32) = (0, 1);
    tuple_param(test_tuple);

    let a = <u32 as From<u8>>::from(1u8);
}

use level_1::{
    level_2::{
        level_3::{
            level_4::{
                level_5::{A, B},
                C, D,
            },
            E, F,
        },
        G, H,
    },
    I, J,
};

mod level_1 {
    pub mod level_2 {
        pub mod level_3 {
            pub mod level_4 {
                pub mod level_5 {
                    pub struct A;
                    pub struct B;
                }
                pub struct C;
                pub struct D;
            }

            pub struct E;
            pub struct F;
        }

        pub struct G;
        pub struct H;
    }

    pub struct I;
    pub struct J;
}
