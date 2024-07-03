@group(0)
@binding(0)
var<storage, read> array_1: array<u32, 10>;

@group(0)
@binding(1)
var<uniform> array_2: array<vec4<u32>, 256>;

@group(1)
@binding(0)
var<storage, read_write> array_3: array<vec2<f32>, 100>;

struct MyStruct {
    x: f32,
    y: f32,
    i: u32,
    j: u32,
}

fn next_bit_string_same_hamming_weight(bit_string: u32) -> u32 {
    let t = bit_string | (bit_string - 1u); // bit_string with least significant 0 set to 1
    let tmp = (~t & (0u - ~t)) - 1u;
    return (t+1) | (tmp >> (countTrailingZeros(bit_string) + 1u));
}

fn function_with_loop(a: u32, b_ptr: ptr<function, u32>) {
    var bits = a;
    loop {
        if (bits & 3u) == 0u {
            return;
        } else {
            bits = bits - 1u;
            *b_ptr += 1u;
        }
    }
}

@compute
@workgroup_size(32)
fn main(
    @builtin(global_invocation_id) global_id: vec3<u32>,
) {
    let start = 10 * global_id.x;

    if (global_id.x >= 10) { return; }
    var a = array_1[global_id.x];

    let end = start + 10;

    for (var id = start; id < end; id += 1u) {
        if (id >= 100) { return; }

        var b = array_3[id].x;

        array_3[id].y = a + b;
    }
}
