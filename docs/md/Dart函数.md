<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 14:54:18
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 15:02:23
 * @Description: Dart函数
-->
# Dart函数

[Dart函数](https://www.dartcn.com/guides/language/language-tour#%E5%87%BD%E6%95%B0)
## 箭头

=> expr 语法是 { return expr; } 的简写。 => 符号 有时也被称为 箭头 语法。

提示： 在箭头 (=>) 和分号 (;) 之间只能使用一个 表达式 ，不能是 语句 。 例如：不能使用 if 语句 ，但是可以是用 条件表达式.

## 参数

函数有两种参数类型: required 和 optional。 required 类型参数在参数最前面， 随后是 optional 类型参数。 命名的可选参数也可以标记为 “@ required” 。 参考下一章节，了解更多细节。

### 命名可选参数

### @required

使用 @required 注释表示参数是 required 性质的命名参数， 该方式可以在任何 Dart 代码中使用（不仅仅是Flutter）。
```dart
const Scrollbar({Key key, @required Widget child})
```
此时 Scrollbar 是一个构造函数， 当 child 参数缺少时，分析器会提示错误。

Required 被定义在 meta package。 无论是直接引入（import） package:meta/meta.dart ，或者引入了其他 package，而这个 package 输出（export）了 meta，比如 Flutter 的 package:flutter/material.dart。

### 位置可选参数

将参数放到 [] 中来标记参数是可选的：

### 默认参数值
在定义方法的时候，可以使用 = 来定义可选参数的默认值。 默认值只能是编译时常量。 如果没有提供默认值，则默认值为 null。

## 联级调用

web 应用的 main() 函数：
```dart
void main() {
  querySelector('#sample_text_id')
    ..text = 'Click me!'
    ..onClick.listen(reverseText);
}
```
**注意**以上代码中的 .. 语法为 级联调用 （cascade）。 使用级联调用， 可以简化在一个对象上执行的多个操作。
