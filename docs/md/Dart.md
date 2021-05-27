<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-21 10:49:28
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 14:52:58
 * @Description: Dart
-->
# Dart

[Dart 中文网](https://www.dartcn.com/)
[Dart github](https://github.com/dart-lang)
[Dart 中文教程](https://www.dartcn.com/guides/language/language-tour#%E9%87%8D%E8%A6%81%E7%9A%84%E6%A6%82%E5%BF%B5)

## 介绍

`Dart` 是免费的并开源于[Github](https://github.com/dart-lang)。

`Dart` 是单线程的。

## 优点

高效
Dart 语法清晰简洁，工具简单而强大。 输入检测可帮助您尽早识别细微错误。 Dart 拥有久经考验的 核心库（core libraries） 和一个已经拥有数以千计的 packages 生态系统

快速
Dart 提供提前编译优化，以在移动设备和 web 上实现可预测的高性能和快速启动。

可移植
Dart 可以编译成 ARM 和 x86 代码，因此 Dart 移动应用程序可以在 iOS，Android 及 更高版本上实现本地运行。 对于 web 应用程序，Dart 可以转换为 JavaScript。

易学
Dart 是面向对象的编程语言，语法风格对于许多现有的开发人员来说都很熟悉。 如果您已经了解 C++，C＃ 或 Java ，那么使用 Dart 也就是分分钟的事情。

响应式
Dart 可以便捷的进行响应式编程。由于快速对象分配和垃圾收集器的实现， 对于管理短期对象（比如 UI 小部件）， Dart 更加高效。 Dart 可以通过 Future 和 Stream 的特性和API实现异步编程。

## 重要的概念
[重要的概念](https://www.dartcn.com/guides/language/language-tour#%E9%87%8D%E8%A6%81%E7%9A%84%E6%A6%82%E5%BF%B5)

在学习 Dart 语言时, 应该基于以下事实和概念：

任何保存在变量中的都是一个 对象 ， 并且所有的对象都是对应一个 类 的实例。 无论是数字，函数和 null 都是对象。所有对象继承自 Object 类。

尽管 Dart 是强类型的，但是 Dart 可以推断类型，所以类型注释是可选的。 在上面的代码中， number 被推断为 int 类型。 如果要明确说明不需要任何类型， 需要使用特殊类型 dynamic 。

Dart 支持泛型，如 List <int> （整数列表）或 List <dynamic> （任何类型的对象列表）。

Dart 支持顶级函数（例如 main（） ）， 同样函数绑定在类或对象上（分别是 静态函数 和 实例函数 ）。 以及支持函数内创建函数 （ 嵌套 或 局部函数 ） 。

类似地， Dart 支持顶级 变量 ， 同样变量绑定在类或对象上（静态变量和实例变量）。 实例变量有时称为字段或属性。

与 Java 不同，Dart 没有关键字 “public” ， “protected” 和 “private” 。 如果标识符以下划线（_）开头，则它相对于库是私有的。 有关更多信息，参考 库和可见性。

标识符 以字母或下划线（_）开头，后跟任意字母和数字组合。

Dart 语法中包含 表达式（ expressions ）（有运行时值）和 语句（ statements ）（没有运行时值）。 例如，条件表达式 condition ? expr1 : expr2 的值可能是 expr1 或 expr2 。 将其与 if-else 语句 相比较，if-else 语句没有值。 一条语句通常包含一个或多个表达式，相反表达式不能直接包含语句。

Dart 工具提示两种类型问题：警告_和_错误。 警告只是表明代码可能无法正常工作，但不会阻止程序的执行。 错误可能是编译时错误或者运行时错误。 编译时错误会阻止代码的执行; 运行时错误会导致代码在执行过程中引发 [异常]（#exception）。

