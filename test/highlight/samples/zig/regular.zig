const std = @import("std");

if_type_expr: if (true) struct {} else struct {} = .{},

const Void = struct {};

const MyBool = enum {
    my_true,
    my_false,
};

const SomeUnion = union {
    top: u0,
    kek: u1,
};

const SomeTaggedUnion = union(enum) {
    top: u0,
    kek: u1,
};

const Tag = enum(u8) {
    a,
    b,
};

const byte_alignment: u8 align(8) = 100;
fn PackedStruct() type {
    return packed struct(u64) {
        a: u32,
        b: u32,
    };
}
const t: bool = true;
const aligned_ptr: *align(1:0:1) bool = &t;
const aligned_multi_ptr: *align(1:0:1) [*]bool = &t;

// Example from zig gpu code
pub fn localInvocationId(comptime ptr: *addrspace(.input) @Vector(3, u32)) void {
    asm volatile (
        \\OpDecorate %ptr BuiltIn LocalInvocationId
        :
        : [ptr] "" (ptr),
    );
}

const parenthesized_expression: u123 = @intCast(1 << (2 << 3));

const ErrorSetDecl = error{SomeError};

comptime {
    const a: ErrorSetDecl!SomeUnion = SomeUnion{ .top = 0 };

    const b = switch (a catch |err| err) {
        SomeUnion.top => |val| val,
        SomeUnion.kek => |val| val,
        else => undefined,
    };

    _ = b;
}

pub fn main() !void {
    const some_type: type = *[][:8][*][*:.{ .mqu = false }]u123;
    _ = some_type;

    const stoqn = [_]u8{ 'k', 'o', 'l', 'e', 'v' };

    std.debug.print("My last {s} is {s} and it's first letter is {s}\n", .{ "name", stoqn, [_]u8{stoqn[0]} });

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = blk: {
        break :blk std.io.getStdOut().writer();
    };
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    switch (6) {
        5 => undefined,
        _ => {
            try stdout.print("Run `zig build test` to run the tests.\n", .{});
        },
    }

    var i: u8 = 0;
    if (false) {
        const k = undefined;
        const a = undefined;
        {
            asm volatile (""
                : [_] "=r,m" (k),
                : [_] "r,m" (a),
                : ""
            );
        }
    } else if (true) {
        for ("proba", 0..) |c, j| {
            _ = c;
            _ = j;
        }
    } else {
        while (false) {}
        while (false) : ({
            i += 1;
            i *= 2;
        }) {}
    }

    const for_expr = for (stoqn) |ch| {
        std.debug.print("{c}", .{ch});
    } else {
        return void;
    };
    _ = for_expr;

    var while_expr = while (i < 3) : ({
        i += 1;
        i *= 2;
    }) {
        std.debug.print("{}", .{i});
    } else {
        return void;
    };
    i = 0;
    while_expr = while (i < 3) {
        i += 1;
    };

    const if_expr = if (i > 0) i else 0;
    _ = if_expr;

    try bw.flush(); // don't forget to flush!
}

const truth linksection("lambda") = "calculus";

fn foo(a: *opaque {}) callconv(.C) void {
    _ = a;
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
