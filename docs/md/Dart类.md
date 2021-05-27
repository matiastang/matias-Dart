<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 15:24:27
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 15:47:43
 * @Description: Dart类
-->
# Dart类

[Dart类](https://www.dartcn.com/guides/language/language-tour#%E5%87%BD%E6%95%B0)

## 介绍

Dart 是一种基于`类`和 `mixin` 继承机制的面向对象的语言。 每个`对象`都是一个`类`的`实例`，所有的`类`都继承于 `Object` 。 基于 `Mixin` 继承意味着每个`类`（除 `Object` 外） 都只有一个`超类`， 一个`类`中的代码可以在其他多个`继承类`中重复使用。

## 获取对象的类型

使用对象的 `runtimeType` 属性， 可以在运行时获取对象的类型， `runtimeType` 属性回返回一个 `Type` 对象。
```dart
print('The type of a is ${a.runtimeType}');
```

## 构造函数

**重要**构造函数不能够被继承， 这意味着父类的命名构造函数不会被子类继承。 如果希望使用父类中定义的命名构造函数创建子类， 就必须在子类中实现该构造函数。

调用父类非默认构造函数
默认情况下，子类的构造函数会自动调用父类的默认构造函数（匿名，无参数）。 父类的构造函数在子类构造函数体开始执行的位置被调用。 如果提供了一个 initializer list （初始化参数列表）， 则初始化参数列表在父类构造函数执行之前执行。 总之，执行顺序如下：

* initializer list （初始化参数列表）
* superclass’s no-arg constructor （父类的无名构造函数）
* main class’s no-arg constructor （主类的无名构造函数）
如果父类中没有匿名无参的构造函数， 则需要手工调用父类的其他构造函数。 在当前构造函数冒号 (:) 之后，函数体之前，声明调用父类构造函数。

下面的示例中，Employee 类的构造函数调用了父类 Person 的命名构造函数。
```dart
class Person {
  String firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
}

main() {
  var emp = new Employee.fromJson({});

  // Prints:
  // in Person
  // in Employee
  if (emp is Person) {
    // Type check
    emp.firstName = 'Bob';
  }
  (emp as Person).firstName = 'Bob';
}
// 输出
// in Person
// in Employee
```
### 初始化列表
除了调用超类构造函数之外， 还可以在构造函数体执行之前初始化实例变量。 各参数的初始化用逗号分隔。

// 在构造函数体执行之前，
// 通过初始列表设置实例变量。
Point.fromJson(Map<String, num> json)
    : x = json['x'],
      y = json['y'] {
  print('In Point.fromJson(): ($x, $y)');
}
警告： 初始化程序的右侧无法访问 this 。

在开发期间， 可以使用 assert 来验证输入的初始化列表。

Point.withAssert(this.x, this.y) : assert(x >= 0) {
  print('In Point.withAssert(): ($x, $y)');
}

### 重定向构造函数
有时构造函数的唯一目的是重定向到同一个类中的另一个构造函数。 重定向构造函数的函数体为空， 构造函数的调用在冒号 (:) 之后。

class Point {
  num x, y;

  // 类的主构造函数。
  Point(this.x, this.y);

  // 指向主构造函数
  Point.alongXAxis(num x) : this(x, 0);
}
### 常量构造函数
如果该类生成的对象是固定不变的， 那么就可以把这些对象定义为编译时常量。 为此，需要定义一个 const 构造函数， 并且声明所有实例变量为 final。

class ImmutablePoint {
  static final ImmutablePoint origin =
      const ImmutablePoint(0, 0);

  final num x, y;

  const ImmutablePoint(this.x, this.y);
}

### 工厂构造函数
当执行构造函数并不总是创建这个类的一个新实例时，则使用 `factory` 关键字。 例如，一个工厂构造函数可能会返回一个 cache 中的实例， 或者可能返回一个子类的实例。

以下示例演示了从缓存中返回对象的工厂构造函数：
```dart
class Logger {
  final String name;
  bool mute = false;

  // 从命名的 _ 可以知，
  // _cache 是私有属性。
  static final Map<String, Logger> _cache =
      <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
```
提示： 工厂构造函数无法访问 this。

## 抽象类
使用 `abstract` 修饰符来定义 抽象类 — 抽象类不能实例化。 抽象类通常用来定义接口，以及部分实现。 如果希望抽象类能够被实例化，那么可以通过定义一个 工厂构造函数 来实现。

## 隐式接口
每个类都隐式的定义了一个接口，接口包含了该类所有的实例成员及其实现的接口。 如果要创建一个 A 类，A 要支持 B 类的 API ，但是不需要继承 B 的实现， 那么可以通过 A 实现 B 的接口。

一个类可以通过 `implements` 关键字来实现一个或者多个接口， 并实现每个接口要求的 API。

## 扩展类（继承）
使用 `extends` 关键字来创建子类， 使用 `super` 关键字来引用父类：

## 重写类成员
子类可以重写实例方法，`getter` 和 `setter`。 可以使用 `@override` 注解指出想要重写的成员：

## noSuchMethod()
当代码尝试使用不存在的方法或实例变量时， 通过重写 noSuchMethod() 方法，来实现检测和应对处理：

class A {
  // 如果不重写 noSuchMethod，访问
  // 不存在的实例变量时会导致 NoSuchMethodError 错误。
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: ' +
        '${invocation.memberName}');
  }
}
除非符合下面的任意一项条件， 否则没有实现的方法不能够被调用：

receiver 具有 dynamic 的静态类型 。

receiver 具有静态类型，用于定义为实现的方法 (可以是抽象的), 并且 receiver 的动态类型具有 noSuchMethod() 的实现， 该实现与 Object 类中的实现不同。

有关更多信息，参考 [noSuchMethod forwarding specification](https://github.com/dart-lang/sdk/blob/master/docs/language/informal/nosuchmethod-forwarding.md).


## **重要**Mixin

Mixin 是复用类代码的一种途径， 复用的类可以在不同层级，之间可以不存在继承关系。

通过 `with` 后面跟一个或多个混入的名称，来 使用 `Mixin` ， 下面的示例演示了两个使用 `Mixin` 的类：
```dart
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person
    with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```
通过创建一个继承自 `Object` 且没有构造函数的类，来 实现 一个 `Mixin` 。 如果 `Mixin` 不希望作为常规类被使用，使用关键字 `mixin` 替换 `class` 。 例如：
```dart
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}
```
指定只有某些类型可以使用的 `Mixin` - 比如， `Mixin` 可以调用 `Mixin` 自身没有定义的方法 - 使用 `on` 来指定可以使用 `Mixin` 的父类类型：
```dart
mixin MusicalPerformer on Musician {
  // ···
}
```
版本提示： mixin 关键字在 Dart 2.1 中被引用支持。 早期版本中的代码通常使用 abstract class 代替。 更多有关 Mixin 在 2.1 中的变更信息，请参见 Dart SDK changelog 和 2.1 mixin specification 。

提示： 对 Mixin 的一些限制正在被移除。 关于更多详情，参考 proposed mixin specification.

有关 Dart 中 Mixin 的理论演变，参考 [A Brief History of Mixins in Dart](https://www.dartcn.com/articles/language/mixins).