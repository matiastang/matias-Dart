<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 15:08:55
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 15:11:30
 * @Description: 运行Dart程序
-->
# 运行Dart程序

[运行Dart程序](https://dart.dev/tools/dart-run)

运行Dart文件
您可以通过传递其相对路径来运行Dart文件：

 dart run tool/debug.dart
运行程序包中的程序
本节中的说明假定您正在dart runDart程序包（当前程序包）顶部的目录中执行命令。有关Dart软件包目录结构的信息，请参见 软件包布局约定。

在依赖包中
您可以运行bin在当前程序包所依赖的任何程序包的目录中分发的程序。要运行这样的程序，请指定依赖的程序包名称和程序名称。如果与程序包名称相同，则可以省略程序名称。

例如，假设您位于依赖于该bar软件包的软件包的顶层目录中。要运行bar软件包（bin/bar.dart）中的主程序，可以使用以下命令：

 dart run bar
如果程序名称与程序包名称不匹配，请使用形式<package name>:<program name>。例如，要运行软件包bin/baz.dart中的bar程序，请使用以下命令：

 dart run bar:baz
该bin目录是唯一可见程序的地方。依赖程序包中的所有其他目录都是私有的。

在当前包中
当当前目录与程序包名称匹配时（即，您name位于与pubspec中的属性匹配的目录中），则可以省略程序包名称。如果程序名称与程序包名称匹配（即它是主程序），那么您也可以省略程序名称。

这是的最短形式dart run，它运行当前程序包的主程序。例如，如果您位于foo软件包的顶层目录中，则此命令运行bin/foo.dart：

 dart run
如果程序名称与程序包名称不匹配，请添加冒号和程序名称。例如，此命令bin/baz.dart在当前程序包中运行：

 dart run :baz
要运行当前程序包中但bin目录中没有的程序，请传递相对路径（如前所示）：

 dart run tool/debug.dart
向main（）提供参数
要向函数提供参数main()，请将其放在命令的末尾：

 dart run tool/debug.dart arg1 arg2
在运行当前程序包的主程序时，请添加程序包名称。这bin/foo.dart是在foo程序包的顶层目录中使用参数运行的示例：

 dart run foo arg1 arg2
调试
要启用调试，请传递一个或多个调试选项。这是启用assert语句的示例：

 dart run --enable-asserts tool/debug.dart
有关dart run --help详细信息，请参见。