<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-21 10:49:01
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-21 11:00:33
 * @Description: Dart之Future
-->
# Dart之Future

[Dart 单线程实现异步处理之 Future (一)](https://www.imooc.com/article/305495)

## 介绍

异步操作来处理耗时任务的方式主要是两种：一种是类似于 Java 的开启多线程，并在线程间通信；另一种是类似于 Dart 的单线程和事件循环 Event Loop；其中 Event Loop 事件循环就是把一系列的（点击事件/滑动事件/网络请求/ IO 事件等）事件存放在 Event Queue 队列中，循环执行从 Event Loop 中获取事件进行执行，直到清空队列事件；

Dart 可以通过 Future 和 Stream 实现异步操作

## Future

### Future Methods
      Future 的应用主要涉及三种状态，分别是未完成状态(UnCompleted / Pending)，完成成功(Completed with Data)，完成失败(Completed with Error)；

      当 Future 任务执行完成之后，通常需要一个回调，这个回调会立即执行，不会添加到事件队列中，其中通过 then() 的成功回调来来监听 Future 执行完成时获取到的结果；通过 catchError() 异常回调来监听 Future 执行失败或者出现异常时的错误信息；通过 whenComplete() 最终回调来获取最终回调，不管成功还是失败；

      小菜做了一个不太严谨的对比，这三种状态类似于 try-catch-finally，其中 try 对应 then() 成功回调，catch 对应 catchError() 异常回调，而 finall 对应 whenComplete() 最终回调；

      Future 还有两个常用的回调，分别是 timeout 超时回调和 asStream() 转换成 Stream 流回调；
### 使用

Future 的使用可以通过 Future Constructors 构造方法或 async-await 方式；
```js
Future.delayed(Duration(seconds: 3), () {
  print('Future.delayed(), CurrentTime = ${DateTime.now().millisecondsSinceEpoch}');
  return 'Future.delayed() result! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}';
}).timeout(Duration(seconds: 1), onTimeout: () => 'Future.delayed() TimeOut! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}')
    .then((val) => print(val))
    .whenComplete(() => print('Future.delayed() whenComplete! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'));
```

Future Constructors
1. Future(FutureOr computation())
      用于返回状态结果的基本构造方法；其中 computation 返回的可以是普通类型也可以是 Future；

factory Future(FutureOr<T> computation()) {
    _Future<T> result = new _Future<T>();
    Timer.run(() {
      try {
        result._complete(computation());
      } catch (e, s) {
        _completeWithErrorCallback(result, e, s);
      }
    });
    return result;
}
      分析源码可知，Future 主要是通过 Timer.run() 来执行，在回调方法中执行 computation();

Future(() => print('Future(FutureOr<T> computation()) 01'));
Future(() {
  print('Future(FutureOr<T> computation()) 02');
  return 'Future(FutureOr<T> computation()) 02 result!';
}).then((val) => print(val));
Future(() {
  print('Future(FutureOr<T> computation()) 03');
  return 'Future(FutureOr<T> computation()) 03 result!';
}).then((val) => print(val)).whenComplete(() => print('Future(FutureOr<T> computation()) 03 whenComplete!'));


2. Future.value([FutureOr value])
      创建一个固定类型的 Future；

Future.value('Future.value() 01').then((val) => print(val));
Future.value('Future.value() 02').then((val) => print(val));
Future.value('Future.value() 03')
    .then((val) => print(val))
    .whenComplete(() => print('Future.value() 03 whenComplete!'));


3. Future.delayed(Duration duration, [FutureOr computation()])
      delayed 是延迟执行，任务会到设置的延迟时间之后再执行；

factory Future.delayed(Duration duration, [FutureOr<T> computation()]) {
    _Future<T> result = new _Future<T>();
    new Timer(duration, () {
      if (computation == null) {
        result._complete(null);
      } else {
        try {
          result._complete(computation());
        } catch (e, s) {
          _completeWithErrorCallback(result, e, s);
        }
      }
    });
    return result;
}
      分析源码可知，与默认的构造方法相比，Timer 只是多了一个 duration，会在 duration 之后调用 computation()；

print('CurrentTime01 = ${DateTime.now().millisecondsSinceEpoch}');
Future.delayed(Duration(seconds: 3), () => print('Future.delayed() 01, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'));
print('CurrentTime02 = ${DateTime.now().millisecondsSinceEpoch}');
Future.delayed(Duration(seconds: 1), () => print('Future.delayed() 02, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'));
print('CurrentTime03 = ${DateTime.now().millisecondsSinceEpoch}');
Future.delayed(Duration(seconds: 2), () {
  print('Future.delayed() 03, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}');
  return 'Future.delayed() 03 result! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}';
}).then((val) => print(val)).whenComplete(() => print('Future.delayed() 03 whenComplete! CurrentTime = ${DateTime.now().millisecondsSinceEpoch}'));
print('CurrentTime04 = ${DateTime.now().millisecondsSinceEpoch}');


4. Future.sync(FutureOr computation())
      sync 是同步方法，任务会被立即执行；

factory Future.sync(FutureOr<T> computation()) {
    try {
      var result = computation();
      if (result is Future<T>) {
        return result;
      } else {
        return new _Future<T>.value(result);
      }
    } catch (error, stackTrace) {
      var future = new _Future<T>();
      AsyncError replacement = Zone.current.errorCallback(error, stackTrace);
      if (replacement != null) {
        future._asyncCompleteError(
            _nonNullError(replacement.error), replacement.stackTrace);
      } else {
        future._asyncCompleteError(error, stackTrace);
      }
      return future;
    }
}
      分析源码可知，与默认的构造方法相比，sync 直接调用 computation()，并未通过 Timer() 的回调；

Future.sync(() => print('Future.sync() 01'));
Future.sync(() {
  print('Future.sync() 02');
  return 'Future.sync() 02 result!';
}).then((val) => print(val));
Future.sync(() {
  print('Future.sync() 03');
  return 'Future.sync() 03 result!';
}).then((val) => print(val)).whenComplete(() => print('Future.value() 03 whenComplete!'));


5. Future.error(Object error, [StackTrace stackTrace])
      error 主要创建一个异常状态的 Future；

Future.error(ArgumentError.notNull('Input'));
Future.error('Future error01')
    .then((val) => print('Future.error01 result = $val'))
    .catchError((val) => print(val));
Future.error('Future error02')
    .then((val) => print('Future.error02 result = $val'))
    .catchError((val) => print(val))
    .whenComplete(() => print('Future.error03 whenComplete!'));


6. Future.microtask(FutureOr computation())
      `microtask` 比较特殊，会创建一个微队列事件的 `Future`，`Dart` 的异步任务队列主要包括 `Event Queue` 普通事件队列和 `Microtask Queue` 微事件队列，其中 `Microtask Queue` 的执行优先级更高，`Future` 默认是 `Event Queue` 普通队列事件。

Future.microtask(() => print('Future.microtask() 01'));
Future.microtask(() {
  print('Future.microtask() 02');
  return 'Future.microtask() 02 result!';
}).then((val) => print(val)).whenComplete(() => print('Future.microtask() 02 whenComplete!'));
Future.microtask(() => print('Future.microtask() 03'));


### Future Static Methods
1. any(Iterable<Future> futures)
      静态方法 any() 是 Futures 数组中完成第一个 Future 的回调监听，包括成功回调 then() 和异常回调 catchError()，其中第一个 Future 完成之后，并不影响其他的 Future 执行；

Future.any([
  Future.delayed(Duration(seconds: 4)).then((val) => 4),
  Future.delayed(Duration(seconds: 2)).then((val) => '2'),
  Future.delayed(Duration(seconds: 3)).then((val) => null),
]).then((val) => print(val));

Future.any([
  Future.error(ArgumentError.notNull('Input')),
  Future.error('Future error01').then((val) => print('Future.error01 result = $val')).catchError((val) => print(val)),
  Future.error('Future error02').then((val) => print('Future.error02 result = $val')).catchError((val) => print(val))
      .whenComplete(() => print('Future.error03 whenComplete!'))
]).then((val) => print('Future.any() --> then()'))
    .catchError((val) => print('Future.any() --> catchError() --> $val'))
    .whenComplete(() => print('Future.any() whenComplete!'));


2. doWhile(FutureOr action())
      静态方法 doWhile() 可以用来执行循环任务，只有当返回内容是 false 或异常时停止；

var i = 0;
Future.doWhile(() {
  ++i;
  return Future.delayed(Duration(seconds: 2), () {
    print('Future.doWhile() $i, CurrentTime = ${DateTime.now().millisecondsSinceEpoch}');
    return i < 6;
  }).then((val) {
    print(val);
    return val;
  });
}.then((val) => print('Future.doWhile -> then() -> $val'))
    .whenComplete(() => print('Future.doWhile -> whenComplete()'));


3. forEach(Iterable elements, FutureOr action(T element))
      静态方法 forEach() 用来遍历执行 elements 中各 item，不止于单一数据类型；

Future.forEach([
  1,
  Future(() => print('Future.forEach() 01')),
  Future(() {
    print('Future.forEach() 02');
    return 'Future.forEach() 02 result!';
  }).then((val) => print(val)),
  'Hello Flutter!',
  Future(() {
    print('Future.forEach() 03');
    return 'Future.forEach() 03 result!';
  }).then((val) => print(val))
      .whenComplete(() => print('Future.forEach() 03 whenComplete!'))
], (val) => print(val))
    .then((val) => print('Future.forEach() -> then() -> $val'))
    .whenComplete(() => print('Future.forEach() -> whenComplete()'));


4. wait(Iterable<Future> futures, {bool eagerError: false, void cleanUp(T successValue)})
      静态方法 wait() 用来等待多个 Futures 完成之后再执行，并收集结果，其中 Futures 时按延迟或其他顺序执行，只有所有的 Futures 结束之后会按 Futures 数组收集；

Future.wait([
  Future.delayed(Duration(seconds: 4)).then((val) {
    print('Future -> 4');
    return 4;
  }).whenComplete(() => print('Future -> 4 whenComplete!')),
  Future.delayed(Duration(seconds: 2)).then((val) {
    print('Future -> 2.toString()');
    return '2';
  }).whenComplete(() => print('Future -> 2.toString() whenComplete!')),
  Future.delayed(Duration(seconds: 3)).then((val) {
    print('Future -> null');
    return null;
  }).whenComplete(() => print('Future -> null whenComplete!')),
]).then((val) => print(val))
    .catchError((val) => print('Future.wait() --> catchError() --> $val'))
    .whenComplete(() => print('Future.wait() whenComplete!'));


      a. Future.wait() 只会捕获 Futures 中第一个异常，且当前 Future 未进行捕获，即：Future 中都进行了 catchError 则不会进入 wait().catchError()；

Future.wait([
  Future.delayed(Duration(seconds: 4)).then((val) {
    print('Future -> 4');
    return 4;
  }).whenComplete(() => print('Future -> 4 whenComplete!')),
  Future.error('Future error01')
      .then((val) => print('Future.error01 result = $val'))
      .catchError((val) => print(val)),
  Future.error(ArgumentError.notNull('Input')),
  Future.error('Future error02')
      .then((val) => print('Future.error02 result = $val'))
      .catchError((val) => print(val))
      .whenComplete(() => print('Future.error02 whenComplete!'))
]).then((val) => print('Future.wait() --> then()'))
    .catchError((val) => print('Future.wait() --> catchError() --> $val'))
    .whenComplete(() => print('Future.wait() whenComplete!'));


      b. wait() 但异常捕获时机与 eagerError 参数相关，eagerError = true 时，Futures 中第一个返回异常时 wait() 立即捕获；eagerError = false 时，需等 Futures 全部执行结束之后才会捕获；

eagerError: true

      c. Futures 中出现异常时，cleanUp 会给每项正常执行的 Future 进行清理操作，传递给 cleanUp 的参数为每个正常执行项的返回内容；

Future.wait([
  Future.delayed(Duration(seconds: 4)).then((val) {
    print('Future -> 4');
    return 4;
  }).whenComplete(() => print('Future -> 4 whenComplete!')),
  Future.error('Future error01')
      .then((val) => print('Future.error01 result = $val'))
      .catchError((val) => print(val)),
  Future.error(ArgumentError.notNull('Input')),
  Future.delayed(Duration(seconds: 2)).then((val) {
    print('Future -> 2.toString()');
    return '2';
  }),
  Future.error('Future error02')
      .then((val) => print('Future.error02 result = $val'))
      .catchError((val) => print(val))
      .whenComplete(() => print('Future.error02 whenComplete!')),
], cleanUp: (val) => print('Future.wait() --> cleanUp --> $val'))
    .then((val) => print('Future.wait() --> then()'))
    .catchError(
        (val) => print('Future.wait() --> catchError() --> $val'))
    .whenComplete(() => print('Future.wait() whenComplete!'));


      Dart Future 案例尝试

      小菜对 Dart 异步的认知还不完全，接下来会继续尝试 await-async 以及 EventLoop 执行顺序等；如有错误和遗漏请多多指导！