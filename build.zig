const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const time_mod = b.addModule("time", .{
        .root_source_file = b.path("time.zig"),
        .target = target,
        .optimize = optimize,
    });

    {
        const tests = b.addTest(.{
            .root_source_file = b.path("main.zig"),
            .target = target,
            .optimize = optimize,
        });

        const run_tests = b.addRunArtifact(tests);
        const tests_step = b.step("test", "Run all the tests.");
        tests_step.dependOn(&run_tests.step);

        tests.root_module.addImport("time", time_mod);
    }
}
