const std = @import("std");

pub fn main() !void {
    std.debug.print("Hello from memory-playground!\n", .{});

    const allocator = std.heap.page_allocator;

    const one_gb = 1_000_000_000;
    const test_value = 64; // can we actually allocated 64GB?
    const memory = try allocator.alloc(u8, test_value * one_gb);
    defer allocator.free(memory);
    
    const sleep_in_secs = 30;
    std.debug.print("Sleeping for {} seconds\n", .{sleep_in_secs});
    std.time.sleep(sleep_in_secs * 1_000_000_000);
}
