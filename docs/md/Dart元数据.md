<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 16:07:35
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 16:08:34
 * @Description: Dart元数据
-->
# Dart元数据

[Dart元数据](https://www.dartcn.com/guides/language/language-tour#%E5%85%83%E6%95%B0%E6%8D%AE)

使用元数据可以提供有关代码的其他信息。 元数据注释以字符 `@` 开头， 后跟对编译时常量 (如 deprecated) 的引用或对常量构造函数的调用。

对于所有 Dart 代码有两种可用注解：`@deprecated`(弃用) 和 `@override`（继承）。 关于 @override 的使用， 参考 扩展类（继承）。 下面是使用 @deprecated 注解的示例：

class Television {
  /// _Deprecated: Use [turnOn] instead._
  @deprecated
  void activate() {
    turnOn();
  }

  /// Turns the TV's power on.
  void turnOn() {...}
}
可以自定义元数据注解。 下面的示例定义了一个带有两个参数的 @todo 注解：

library todo;

class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
使用 @todo 注解的示例：

import 'todo.dart';

@Todo('seth', 'make this do something')
void doSomething() {
  print('do something');
}
元数据可以在 library、 class、 typedef、 type parameter、 constructor、 factory、 function、 field、 parameter 或者 variable 声明之前使用，也可以在 import 或者 export 指令之前使用。 使用反射可以在运行时获取元数据信息。

