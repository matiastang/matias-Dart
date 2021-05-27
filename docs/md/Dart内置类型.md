<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 14:22:13
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 15:22:11
 * @Description: 内置类型
-->
# 内置类型

[内置类型](https://www.dartcn.com/guides/language/language-tour#built-in-types)

## Number

### int

整数值不大于64位， 具体取决于平台。 在 Dart VM 上， 值的范围从 -2^63 到 2^63 - 1. Dart 被编译为 JavaScript 时，使用 JavaScript numbers, 值的范围从 -2^53 到 2^53 - 1.

### double

64位（双精度）浮点数，依据 IEEE 754 标准。

int 和 double 都是 num. 的亚类型。 num 类型包括基本运算 +， -， /， 和 *， 以及 abs()， ceil()， 和 floor()， 等函数方法。 （按位运算符，例如»，定义在 int 类中。） 如果 num 及其亚类型找不到你想要的方法， 尝试查找使用 dart:math 库。

## String

* Dart 字符串是一组 UTF-16 单元序列。 字符串通过单引号或者双引号创建。
* 字符串可以通过 ${expression} 的方式内嵌表达式。 如果表达式是一个标识符，则 {} 可以省略。 在 Dart 中通过调用就对象的 toString() 方法来得到对象相应的字符串。
* 可以使用 + 运算符来把多个字符串连接为一个，也可以把多个字面量字符串写在一起来实现字符串连接：
* 使用连续三个单引号或者三个双引号实现多行字符串对象的创建：
* 使用 r 前缀，可以创建 “原始 raw” 字符串
```dart
var s = r"In a raw string, even \n isn't special.";
```
* 参考 Runes 来了解如何在字符串中表达 Unicode 字符。
* 一个编译时常量的字面量字符串中，如果存在插值表达式，表达式内容也是编译时常量， 那么该字符串依旧是编译时常量。 插入的常量值类型可以是 null，数值，字符串或布尔值。

## Boolean

* Dart 使用 bool 类型表示布尔值。 Dart 只有字面量 true and false 是布尔类型， 这两个对象都是编译时常量。

## List

* 几乎每种编程语言中最常见的集合可能是 array 或有序的对象集合。 在 Dart 中的 Array 就是 List 对象， 通常称之为 List 。
* Dart 中的 List 字面量非常像 JavaScript 中的 array 字面量。

## Set

* 在 Dart 中 Set 是一个元素唯一且无需的集合。 Dart 为 Set 提供了 Set 字面量和 Set 类型。
Map 字面量语法同 Set 字面量语法非常相似。 因为先有的 Map 字母量语法，所以 {} 默认是 Map 类型。   如果忘记在 {} 上注释类型或赋值到一个未声明类型的变量上，   那么 Dart 会创建一个类型为 Map<dynamic, dynamic> 的对象。
* 使用 add() 或 addAll() 为已有的 Set 添加元素：
* 使用 .length 来获取 Set 中元素的个数：

## Map

* Map 是用来关联 keys 和 values 的对象。 keys 和 values 可以是任何类型的对象。在一个 Map 对象中一个 key 只能出现一次。 但是 value 可以出现多次。 Dart 中 Map 通过 Map 字面量 和 Map 类型来实现。

## Rune

* 在 Dart 中， Rune 用来表示字符串中的 UTF-32 编码字符。

Unicode 定义了一个全球的书写系统编码， 系统中使用的所有字母，数字和符号都对应唯一的数值编码。 由于 Dart 字符串是一系列 UTF-16 编码单元， 因此要在字符串中表示32位 Unicode 值需要特殊语法支持。

表示 Unicode 编码的常用方法是， \uXXXX, 这里 XXXX 是一个4位的16进制数。 例如，心形符号 (♥) 是 \u2665。 对于特殊的非 4 个数值的情况， 把编码值放到大括号中即可。 例如，emoji 的笑脸 (�) 是 \u{1f600}。

**重要**String 类有一些属性可以获得 rune 数据。 属性 codeUnitAt 和 codeUnit 返回16位编码数据。 属性 runes 获取字符串中的 Rune 。

**提示**： 谨慎使用 list 方式操作 Rune 。 这种方法很容易引发崩溃， 具体原因取决于特定的语言，字符集和操作。 有关更多信息，参考 [How do I reverse a String in Dart? on Stack Overflow](http://stackoverflow.com/questions/21521729/how-do-i-reverse-a-string-in-dart).

## Symbol

一个 Symbol 对象表示 Dart 程序中声明的运算符或者标识符。 你也许永远都不需要使用 Symbol ，但要按名称引用标识符的 API 时， Symbol 就非常有用了。 因为代码压缩后会改变标识符的名称，但不会改变标识符的符号。 通过字面量 Symbol ，也就是标识符前面添加一个 # 号，来获取标识符的 Symbol 。

#radix
#bar
Symbol 字面量是编译时常量。

## 类型判定运算符

as， is， 和 is! 运算符用于在运行时处理类型检查：

Operator	Meaning
as	Typecast (也被用于指定库前缀)
is	True if the object has the specified type
is!	False if the object has the specified type
例如， obj is Object 总是 true。 但是只有 obj 实现了 T 的接口时， obj is T 才是 true。

使用 as 运算符将对象强制转换为特定类型。 通常，可以认为是 is 类型判定后，被判定对象调用函数的一种缩写形式。 请考虑以下代码：
```dart
if (emp is Person) {
  // Type check
  emp.firstName = 'Bob';
}
```
使用 as 运算符进行缩写：
```dart
(emp as Person).firstName = 'Bob';
```

## 赋值运算符
使用 = 为变量赋值。 使用 ??= 运算符时，只有当被赋值的变量为 null 时才会赋值给它。

// 将值赋值给变量a
a = value;
// 如果b为空时，将变量赋值给b，否则，b的值保持不变。
b ??= value;
