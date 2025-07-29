const std = @import("std");

pub fn build(b: *std.Build) void {
    const bin = b.addExecutable(.{
        .name = "memory-playground",
        .root_source_file = b.path("memory-playground.zig"),
        .target = b.graph.host,
    });

    b.installArtifact(bin);
}
