const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const time = b.addModule("time", .{
        .source_file = .{ .path = "time.zig" },
    });

    {
        const target = b.standardTargetOptions(.{});
        const optimize = b.standardOptimizeOption(.{});

        const tests = b.addTest(.{
            .root_source_file = .{ .path = "main.zig" },
            .target = target,
            .optimize = optimize,
        });
        tests.addModule("time", time);

        const run_tests = b.addRunArtifact(tests);
        const tests_step = b.step("test", "Run all the tests.");
        tests_step.dependOn(&run_tests.step);
    }
}
