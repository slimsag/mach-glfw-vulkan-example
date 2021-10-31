const std = @import("std");

const glfw = @import("libs/mach-glfw/build.zig");
const vkgen = @import("libs/vulkan-zig/generator/index.zig");
const zigvulkan = @import("libs/vulkan-zig/build.zig");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("mach-glfw-vulkan-example", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    // vulkan-zig: Create a step that generates vk.zig (stored in zig-cache) from the provided vulkan registry.
    const gen = vkgen.VkGenerateStep.init(b, "libs/vulkan-zig/examples/vk.xml", "vk.zig");
    exe.addPackage(gen.package);

    // mach-glfw
    exe.addPackagePath("glfw", "libs/mach-glfw/src/main.zig");
    glfw.link(b, exe, .{});

    // shader resources, to be compiled using glslc
    const res = zigvulkan.ResourceGenStep.init(b, "resources.zig");
    res.addShader("triangle_vert", "shaders/triangle.vert");
    res.addShader("triangle_frag", "shaders/triangle.frag");
    exe.addPackage(res.package);

    // Link MoltenVK if targeting MacOS.
    const final_target = (std.zig.system.NativeTargetInfo.detect(b.allocator, exe.target) catch unreachable).target;
    switch (final_target.os.tag) {
        .macos => {
            exe.addLibPath("/opt/homebrew/Cellar/molten-vk/1.1.5/lib");
            exe.linkSystemLibrary("MoltenVK");
        },
        else => {},
    }

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
