
# Dart的JIT和AOT

## 介绍

程序的运行方式有两种

1. 静态编译（`AOT`：Ahead of Time）
> 静态编译的程序在执行前全部被翻译为机器码，通常将这种类型称为`AOT （Ahead of time compiler）`即 **提前编译**；如`C`、`C++`。
2. 动态解释（`JIT`：Just In Time）
> 动态解释则是一句一句边翻译边运行，通常将这种类型称为`JIT（Just-in-time`）即**即时编译**。如`JavaScript`、`Python`。

程序运行的方式和具体的语言没有强制关系，比如`Python`，既可以`JIT`，也可以`AOT`。

## Dart的JIT和AOT

`Dart`在开发过程中使用`JIT`，因此每次改都不需要再编译成字节码。节省了大量时间。
在部署中使用`AOT`生成高效的ARM代码以保证高效的性能。
`Dart` 是少数同时支持 `JIT（Just In Time，即时编译）`和 `AOT（Ahead of Time，运行前编译）`的语言之一。
`JIT` 在运行时即时编译，在开发周期中使用，可以动态下发和执行代码，开发测试效率高，但运行速度和执行性能则会因为运行时即时编译受到影响。

## 总结

* 在开发期使用 `JIT` 编译，可以缩短产品的开发周期。`Flutter` 最受欢迎的功能之一热重载，正是基于此特 性。
* 在发布期使用 `AOT`，就不需要像 `React Native` 那样在跨平台 `JavaScript` 代码和原生 `Android`、`iOS` 代码之间建立低效的方法调用映射关系。

所以说，`Dart` 具有运行速 度快、执行性能好的特点。