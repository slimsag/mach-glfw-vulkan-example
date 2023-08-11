const std = @import("std");
const glfw = @import("mach_glfw");

pub fn build(b: *std.build.Builder) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const vulkan_dep = b.dependency("vulkan", .{});
    const vulkan_mod = vulkan_dep.module("vulkan-zig-generated");

    const glfw_dep = b.dependency("mach_glfw", .{ .target = target, .optimize = optimize });
    const glfw_mod = glfw_dep.module("mach-glfw");

    const exe = b.addExecutable(.{
        .name = "mach-glfw-vulkan-example",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.main_pkg_path = .{ .path = "." };
    try glfw.link(b, exe);
    exe.addModule("vulkan", vulkan_mod);
    exe.addModule("glfw", glfw_mod);
    b.installArtifact(exe);

    const compile_vert_shader = b.addSystemCommand(&.{
        "glslc",
        "shaders/triangle.vert",
        "--target-env=vulkan1.1",
        "-o",
        "shaders/triangle_vert.spv",
    });
    const compile_frag_shader = b.addSystemCommand(&.{
        "glslc",
        "shaders/triangle.frag",
        "--target-env=vulkan1.1",
        "-o",
        "shaders/triangle_frag.spv",
    });

    exe.step.dependOn(&compile_vert_shader.step);
    exe.step.dependOn(&compile_frag_shader.step);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| run_cmd.addArgs(args);

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
