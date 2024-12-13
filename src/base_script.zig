const BASE_SCRIPT =
    //const std = @import("std");
    //
    //pub fn build(b:*std.Build) void {
    //    const exe = b.addExecutable(.{
    //        .name = "%NAME%",
    //        .root_source_file = b.path("%MAINPATH%"),
    //        .target = b.standardTargetOptions(.{}),
    //        .optimize = b.standardOptimizeOption(.{}),
    //    });
    //
    //    b.installArtifact(exe);
    //}
;

pub fn getScript(buf:*[]u8, name:[]const u8, path:[]const u8) void {
	// FIXME - sub name and path into the base script, and return the result
}
