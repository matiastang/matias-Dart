<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 14:30:43
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 14:39:00
 * @Description: 变量
-->
# 变量

## 声明变量

创建一个变量并进行初始化:
```dart
var name = 'Bob';
```
变量仅存储对象引用，这里的变量是 name 存储了一个 String 类型的对象引用。 “Bob” 是这个 String 类型对象的值。
name 变量的类型被推断为 String 。 但是也可以通过指定类型的方式，来改变变量类型。 如果对象不限定为单个类型，可以指定为 对象类型 或 动态类型， 参考 设计指南。
```dart
dynamic name = 'Bob';
```
另一种方式是显式声明可以推断出的类型：
```dart
String name = 'Bob';
```

## 变量默认值

未初始化的变量默认值是 null。即使变量是数字 类型默认值也是 null，因为在 Dart 中一切都是对象，数字类型 也不例外。
```dart
int lineCount;
assert(lineCount == null);// 在生产环境代码中 assert() 函数会被忽略，不会被调用。 在开发过程中, assert(condition) 会在非 true 的条件下抛出异常.有关更多信息，参考 Assert.
```

## 常量

使用过程中从来不会被修改的变量， 可以使用 `final` 或 `const`。

Final 变量的值只能被设置一次； Const 变量在编译时就已经固定 (Const 变量 是隐式 Final 的类型.) 最高级 final 变量或类变量在第一次使用时被初始化。

**提示**： 实例变量可以是 final 类型但不能是 const 类型。 必须在构造函数体执行之前初始化 final 实例变量 —— 在变量声明中，参数构造函数中或构造函数的初始化列表中进行初始化。

### final
```dart
final name = 'Bob'; // Without a type annotation
final String nickname = 'Bobby';
```
final 变量只能被设置一次。

### const

如果需要在**编译时**就固定变量的值，可以使用 const 类型变量。 如果 Const 变量是类级别的，需要标记为 static const。 在这些地方可以使用在编译时就已经固定不变的值，字面量的数字和字符串， 固定的变量，或者是用于计算的固定数字：
```dart
const bar = 1000000; // 压力单位 (dynes/cm2)
const double atm = 1.01325 * bar; // 标准气压
```
非 Final ， 非 const 的变量是可以被修改的，即使这些变量 曾经引用过 const 值。