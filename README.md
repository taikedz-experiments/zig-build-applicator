# Zig Build Printer

This repo has no `build.zig`

The intent is that eventually this will be a program called `addzb` we will be able to do

```zig
zig build-exe src/addzb.zig &&
    ./addzb -z build.zig.zon > build.zig &&
    zig build
```

That is, this program is meant to produce simple zig build files.

It would also be able to process `build.zig.zon` files to add the dependencies into the build script, for less faff.

```zig
.{
  .dependencies = .{
    .zg = .{
      .url = "https://codeberg.org/dude_the_builder/zg/archive/v0.13.2.tar.gz",
      .hash = "122055beff332830a391e9895c044d33b15ea21063779557024b46169fb1984c6e40",

      // Can this exist in the Zon data without interfering ?
      .aliases = .{
        "zg_CaseData": "CaseData",
      },
    },
  },
}
```

resulting in a build file like

```zig
const std = @import("std");

pub fn build(b:*std.Build) void {
    const exe = b.addExecutable(.{
        .name = "prog-name", // user input
        .root_source_file = b.path("src/main.zig"), // user input
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    // Information taken from the .aliases section
    const dep__zg = b.dependency("zg", .{});
    exe.root_module.addImport("zg_CaseData", dep__zg.module("CaseData"));

    b.installArtifact(exe);
}
```

Doing this in Zig directly is still difficult for me. I might yet settle for doing it in python in the meantime...

