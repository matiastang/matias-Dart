<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-21 11:54:30
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 16:03:03
 * @Description: Dart异步编程
-->
# Dart异步编程

[Dart异步编程：Isolate和事件循环](https://melrose1994.com/index.php/2020/04/14/dart%e5%bc%82%e6%ad%a5%e7%bc%96%e7%a8%8b%ef%bc%9aisolate%e5%92%8c%e4%ba%8b%e4%bb%b6%e5%be%aa%e7%8e%af/)
[stream](https://www.dartcn.com/guides/libraries/library-tour#stream)
[future](https://www.dartcn.com/guides/libraries/library-tour#future)

## 介绍

异步编程通常使用回调方法来实现，但是 Dart 提供了其他方案：Future 和 Stream 对象。 Future 类似与 JavaScript 中的 Promise ， 代表在将来某个时刻会返回一个结果。 Stream 类可以用来获取一系列的值，比如，一些列事件。

 从 Dart 2.1 开始，使用 Future 和 Stream 不需要导入 dart:async ， 因为 dart:core 库 export 了这些类。
## Future

`then().catchError()` 组合是 `try-catch` 的异步版本。
### then()

### catchError()

### wait()

等待它们全部完成后再继续执行。 使用 `Future.wait()` 静态方法管理多个 `Future` 以及等待它们完成：


### await async

## Stream

在 Dart API 中 Stream 对象随处可见，Stream 用来表示一些列数据。 例如，HTML 中的按钮点击就是通过 stream 传递的。 同样也可以将文件作为数据流来读取。
### 监听流数据

如果只关心其中一个事件，可以使用，例如，first， last，或 single 属性来获取。 要在处理时间前对事件进行测试，可以使用，例如 firstWhere()， lastWhere()， 或 singleWhere() 方法。

如果只关心事件中的一个子集，可以使用，例如，skip()， skipWhile()，take()，takeWhile()， 和 where()。

#### listen()

####  await for

### 传递流数据

#### transform() 

生成具有不同类型数据的流

### 处理错误和完成

处理错误和完成代码方式， 取决于使用的是 异步 for 循环（await for）还是 Stream API 。

* 如果使用的是异步 for 循环， 那么通过 try-catch 来处理错误。 代码位于异步 for 循环之后， 会在 stream 被关闭后执行。
* 如果使用的是 Stream API， 那么通过注册 onError 监听来处理错误。 代码位于注册的 onDone 中， 会在 stream 被关闭后执行。

## Isolates
大多数计算机中，甚至在移动平台上，都在使用多核CPU。 为了有效利用多核性能，开发者一般使用共享内存数据来保证多线程的正确执行。 然而， 多线程共享数据通常会导致很多潜在的问题，并导致代码运行出错。

所有 Dart 代码都在隔离区（ isolates ）内运行，而不是线程。 每个隔离区都有自己的内存堆，确保每个隔离区的状态都不会被其他隔离区访问。

有关更多信息，请参考 [dart:isolate library documentation](https://api.dartlang.org/stable/dart-isolate) 。
## Isolate和事件循环

尽管Dart是单线程语言，但它支持Future、Stream等其他内容。 本文介绍了Dart支持后台工作的基础：Isolate和事件循环。

Isolate
所有Dart代码都在isolate中运行程序。它就像是机器上的一个小空间，具有自己的私有内存块和一个运行事件循环的单个线程。

![dart线程](./images/dart线程.png)

隔离区具有自己的`内存`和`运行事件循环`的单个执行线程

在许多其他语言（例如C ++）中，可以让多个线程共享同一内存并运行所需的任何代码。 但是，在Dart中，每个线程都与自己的内存处于隔离状态。

许多Dart应用程序都在单个隔离区(isolate)中运行所有代码，但是如果需要，可以同时拥有多个隔离区(isolate)。 如果要执行的计算量非常大，以至于如果它在主隔离区中运行，可能会导致丢帧，那么可以使用Isolate.spawn()或Flutter的compute()函数。 这两个函数都创建了一个单独的隔离区(isolate)来进行数字运算，使主隔离区程序可以自由地重建和呈现小部件树。

 
![dart隔离](./images/dart隔离.png)


两个隔离区，每个隔离区都有自己的内存和线程

新隔离区具有自己的事件循环和内存，即使原始隔离区是该新隔离区的父级，也不允许其访问。

实际上，隔离区之间一起工作的唯一方法是通过来回传递消息。 一个隔离区向另一个发送消息，接收隔离区使用其事件循环来处理该消息。

缺少共享内存听起来可能会很严格，尤其是如果之前使用的是Java或C ++之类的语言时，但这对Dart编码人员来说有一些关键的好处。

例如，隔离区中的内存分配和垃圾回收不需要锁。  这对于Flutter应用程序效果很好，例如有时需要快速构建和移除一堆小部件。

使用Isolate
要使用隔离区来进行并发编程:

import 'dart:isolate';
Dart
该library主要包含下面几个类：
   1、 Capability:当通过其他隔离区时返回相同一个不可伪造的对象。
   2、 Isolate:Dart执行上下文的隔离区。
   3、 RawReceivePort:
   4、 ReceivePort:与SendPort一起，是隔离区之间唯一的通信方式。
   5、 SendPort:将消息发送到其ReceivePorts。

要创建Isolate，可以使用spawn方法。而且必须为spawn方法提供一个带有单个参数[SendPort]的方法。 通常，此参数表示隔离应用于发送回通知消息的端口：

Isolate isolate;

 

void start() async {
ReceivePort receivePort= ReceivePort(); //port for this main isolate to receive messages.
isolate = await Isolate.spawn(runTimer, receivePort.sendPort);
receivePort.listen((data) {
stdout.write('RECEIVE: ' + data + ', ');
});
}

 

void runTimer(SendPort sendPort) {
int counter = 0;
Timer.periodic(new Duration(seconds: 1), (Timer t) {
counter++;
String msg = 'notification ' + counter.toString();
stdout.write('SEND: ' + msg + ' - ');
sendPort.send(msg);
});
}
Dart
上面的例子中，使用start()方法创建一个端口并生成一个Isolate。start方法被标记为async,因此可以等待Isolate创建的响应以便可以存储对新Isolate的引用。
spawn有两个参数，一个要执行的回调的函数runTimer,和一个端口(sendPort)，回调可以用来将消息发送回调用者。端口是与Isolate通信的方式。这个例子将其设置为单向通行(从隔离区发送信息到接收者)，但它可以是双向的。在start()方法的最后是监听来自定义isolate的消息。
上面产生的隔离区可以无限期地持续执行下去。 这是因为创造了一个计时器，每秒钟都会执行。 但是如果想停止隔离区代码运行，可以使用kill方法。
void stop(){

print("kill isolate");
isolate?.kill(priority: Isolate.immediate);

isolate =null;

}
Dart
## 事件循环
当应用程序启动，到应用程序停止，会发生一系列事件：来自磁盘的I/O，来自用户的手指点击……各种各样的东西。应用无法预测这些事件何时发生或以什么顺序发生，因此必须使用一个永不阻塞的线程来处理所有这些事件。 因此，应用运行一个事件循环。 它从事件队列中获取最先提交的的事件来进行处理，返回到下一个事件，进行处理，依此类推，直到事件队列为空。

![dart runloop](./images/dart runloop.png)

事件循环一次处理一个事件

当事件执行完成时，线程会挂起，等待下一个事件。 它可以触发垃圾回收等等。

Dart用于异步编程的所有高级API和语言功能（Future、Steam、async、await）都基于此事件循环而构建。