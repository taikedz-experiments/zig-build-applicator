const std = @import("std");
const scripter = @import("base_script.zig");

const IoTrio = struct {
    in: std.io.GenericReader,
    out: std.io.GenericWriter,
    err: std.io.GenericWriter,
};

fn getIo() IoTrio {
    const stdout = std.io.getStdOut().writer();

    var stdin_bo = std.io.bufferedReader(std.io.getStdIn().reader());
    const stdin = stdin_bo.reader();

    return IoTrio{
        .in = stdin,
        .out = stdout,
        .err = std.debug,
    };
}

fn ask(trio:IoTrio, buf:*[]u8, message:[]const u8) ![]u8 {
    trio.err.print("{s} :", .{message});
    return trio.in.readUntilDelemiterOrEof(buf, '\n');
}

pub fn main() !void {
    const trio = getIo();

    var buf:[4096]u8 = undefined;

    const app_name = try ask(trio, &buf, "Name of app") orelse unreachable;
    const src_path = try ask(trio, &buf, "Path to script") orelse unreachable;

    const filled_script = scripter.getScript(&buf, app_name, src_path);

    try trio.out.print("{s}\n", .{filled_script});
}

