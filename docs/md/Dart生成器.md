<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 15:58:19
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 16:01:07
 * @Description: Dart生成器
-->
# Dart生成器

[Dart生成器](https://www.dartcn.com/guides/language/language-tour#%E7%94%9F%E6%88%90%E5%99%A8)

## 介绍

当您需要延迟生成( `lazily produce` )一系列值时（同`JS`的`yield`类似）， 可以考虑使用_生成器函数_。 Dart 内置支持两种生成器函数：

* Synchronous 生成器： 返回一个 Iterable 对象（可迭代）。
* Asynchronous 生成器： 返回一个 Stream 对象（流）。

## Synchronous 生成器

通过在函数体标记 `sync*`， 可以实现一个同步生成器函数。 使用 `yield` 语句来传递值：
```dart
Iterable<int> naturalsTo(int n) sync* {
  int k = 0;
  while (k < n) yield k++;
}
```

## Asynchronous 生成器

通过在函数体标记 `async*`， 可以实现一个异步生成器函数。 使用 `yield` 语句来传递值：
```dart
Stream<int> asynchronousNaturalsTo(int n) async* {
  int k = 0;
  while (k < n) yield k++;
}
```
如果生成器是递归的，可以使用 `yield*` 来提高其性能：
```dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
```
有关生成器的更多信息，请参考文章 [Dart Language Asynchrony Support: Phase 2](https://www.dartcn.com/articles/language/beyond-async) 。

