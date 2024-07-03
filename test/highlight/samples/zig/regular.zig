const std = @import("std");

const Void = struct {};

const MyBool = enum {
    my_true,
    my_false,
};

const SomeUnion = union(enum) {
    top: u0,
    kek: u1,
};

comptime {
    const a: anyerror!SomeUnion = SomeUnion{.top = 0};

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

    std.debug.print("My last {s} is {s} and it's first letter is {s}\n", .{ "name", stoqn, [_]u8{ stoqn[0] } });

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

    if (false) {
        const k = undefined;
        const a = undefined;
        {
            asm volatile (""
                : [_] "=r,m" (k)
                : [_] "r,m" (a)
                : ""
            );
        }
    } else if (true) {
        for ("proba", 0..) |c, i| {
            _ = c;
            _ = i;
        }
    } else {
        while (false) {
            // ...
        }
    }

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
