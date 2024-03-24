# mach-glfw Vulkan example

This is an example for how to use [mach-glfw](https://github.com/hexops/mach-glfw) and [vulkan-zig](https://github.com/snektron/vulkan-zig) together to create a basic Vulkan window.

This is nearly a 1:1 copy of the [vulkan-zig example](https://github.com/Snektron/vulkan-zig/tree/master/examples) by @snektron, the only difference is using [mach-glfw](https://github.com/hexops/mach-glfw).

![](https://user-images.githubusercontent.com/3173176/139573985-d862f35a-e78e-40c2-bc0c-9c4fb68d6ecd.png)

## Getting started

### Install the Vulkan SDK

You must install the LunarG Vulkan SDK: https://vulkan.lunarg.com/sdk/home

### Clone the repository and dependencies

```sh
git clone https://github.com/hexops/mach-glfw-vulkan-example

cd mach-glfw-vulkan-example
```

### Ensure glslc is on your PATH

On MacOS, you may e.g. place the following in your `~/.zprofile` file:

```sh
export PATH=$PATH:$HOME/VulkanSDK/1.3.280.0/macOS/bin/
```

### Run the example

```sh
zig build run
```

### Cross compilation

Vulkan requires a fairly heavy-weight SDK, at this time cross compilation is not possible.
