# mach/glfw Vulkan example <a href="https://hexops.com"><img align="right" alt="Hexops logo" src="https://raw.githubusercontent.com/hexops/media/main/readme.svg"></img></a>

This is an example for how to use [mach-glfw](https://github.com/hexops/mach-glfw) and [vulkan-zig](https://github.com/snektron/vulkan-zig) together to create a basic Vulkan window.

This is nearly a 1:1 copy of the [vulkan-zig example](https://github.com/snektron/vulkan-zig) by @snektron, the only difference is using [mach-glfw](https://github.com/hexops/mach-glfw) and MoltenVK on MacOS.

## Getting started

### Ensure glslc is on your PATH

[vulkan-zig](github.com/snektron/vulkan-zig) uses `glslc` to compile GLSL shaders for Vulkan, if you're on Mac you can install it using:

```
brew install glslang
sudo ln -s $(which glslangValidator) /usr/local/bin/glslc
brew install molten-vk
```

Otherwise see https://github.com/google/shaderc#downloads

### Install the Vulkan SDK

You must install the LunarG Vulkan SDK: https://vulkan.lunarg.com/sdk/home

### Clone the repository and dependencies

```sh
git clone --recurse-submodules https://github.com/hexops/mach-glfw-vulkan-example
```

### Run the example

```sh
zig build run
```
