<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 15:51:54
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 15:56:44
 * @Description: Dart库
-->
# Dart库

[Dart库](https://www.dartcn.com/guides/language/language-tour#%E5%BA%93%E5%92%8C%E5%8F%AF%E8%A7%81%E6%80%A7)

import 和 library 指令可以用来创建一个模块化的，可共享的代码库。 库不仅提供了 API ，而且对代码起到了封装的作用： 以下划线 (_) 开头的标识符仅在库内可见。 每个 Dart 应用程序都是一个库 ，虽然没有使用 library 指令。

库可以通过包来分发。有关 pub（集成在SDK中的包管理器）的信息，请参考 [Pub Package 和 Asset Manager](https://www.dartcn.com/tools/pub)。

## 使用库
通过 import 指定一个库命名空间中的内如如何在另一个库中使用。 例如，Dart Web应用程序通常使用 dart:html 库，它们可以像这样导入：

import 'dart:html';
import 参数只需要一个指向库的 URI。 对于内置库，URI 拥有自己特殊的dart: 方案。 对于其他的库，使用系统文件路径或者 package: 方案 。 package: 方案指定由包管理器（如 pub 工具）提供的库。例如：

import 'package:test/test.dart';
提示： URI 代表统一资源标识符。 URL（统一资源定位符）是一种常见的URI。

## 指定库前缀
如果导入两个存在冲突标识符的库， 则可以为这两个库，或者其中一个指定前缀。 例如，如果 library1 和 library2 都有一个 Element 类， 那么可以通过下面的方式处理：

import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// 使用 lib1 中的 Element。
Element element1 = Element();

// 使用 lib2 中的 Element。
lib2.Element element2 = lib2.Element();
### 导入库的一部分
如果你只使用库的一部分功能，则可以选择需要导入的 内容。例如：

// Import only foo.
import 'package:lib1/lib1.dart' show foo;

// Import all names EXCEPT foo.
import 'package:lib2/lib2.dart' hide foo;

### 延迟加载库
Deferred loading (也称之为 lazy loading) 可以让应用在需要的时候再加载库。 下面是一些使用延迟加载库的场景：

减少 APP 的启动时间。
执行 A/B 测试，例如 尝试各种算法的 不同实现。
加载很少使用的功能，例如可选的屏幕和对话框。
要延迟加载一个库，需要先使用 `deferred as` 来导入：

import 'package:greetings/hello.dart' deferred as hello;
当需要使用的时候，使用库标识符调用 `loadLibrary()` 函数来加载库：

Future greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
在前面的代码，使用 await 关键字暂停代码执行一直到库加载完成。 关于 async 和 await 的更多信息请参考 异步支持。

在一个库上你可以多次调用 loadLibrary() 函数。但是该库只是载入一次。

使用延迟加载库的时候，请注意一下问题：

延迟加载库的常量在导入的时候是不可用的。 只有当库加载完毕的时候，库中常量才可以使用。
在导入文件的时候无法使用延迟库中的类型。 如果你需要使用类型，则考虑把接口类型移动到另外一个库中， 让两个库都分别导入这个接口库。
Dart 隐含的把 loadLibrary() 函数导入到使用 deferred as 的命名空间 中。 loadLibrary() 方法返回一个 Future。