const std = @import("std");

const THREAD_COUNT = 128;
const ALLOC_SIZE = 512 * 1024 * 1024; // 512 MB per thread

fn memory_stress_thread(thread_id: usize) void {
    var allocator = std.heap.page_allocator;
    const buffer = allocator.alloc(u8, ALLOC_SIZE) catch return;
    defer allocator.free(buffer);

    var prng = std.Random.DefaultPrng.init(@intCast(thread_id));
    for (buffer) |*byte| {
        byte.* = prng.random().int(u8);
    }
    std.debug.print("Thread {d} finished\n", .{thread_id});
}

pub fn main() !void {
    var threads: [THREAD_COUNT]std.Thread = undefined;
    for (&threads, 0..) |*t, i| {
        t.* = try std.Thread.spawn(.{}, memory_stress_thread, .{@as(usize, i)});
    }
    for (&threads) |*t| {
        t.join();
    }
    std.debug.print("All threads finished\n", .{});
}