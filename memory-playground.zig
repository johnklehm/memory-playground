const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello from memory-playground!\n", .{});

    const allocator = std.heap.page_allocator;

    const one_gb = 1_000_000_000;
    const test_value = 64; // can we actually allocated 64GB?
    const memory = try allocator.alloc(u8, test_value * one_gb);
    defer allocator.free(memory);

    std.debug.print("Sleeping for {}\n", .{test_value});
    std.time.sleep(30_000_000_000); // 30 sec
}
