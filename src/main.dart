/*
 * @Author: tangdaoyong
 * @Date: 2021-05-27 15:03:52
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 15:16:53
 * @Description: 入口
 */
/// 返回一个函数，返回的函数参数与 [addBy] 相加。
Function makeAdder(num addBy) {
  // 捕获了addBy
  return (num i) => addBy + i;
}

// 这样运行应用： dart args.dart 1 test
void main(List<String> arguments) {
  print('main函数的参数为$arguments');

  // 创建一个加 2 的函数。
  var add2 = makeAdder(2);

  // 创建一个加 4 的函数。
  var add4 = makeAdder(4);

  assert(add2(3) == 5);
  assert(add4(3) == 7);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
// 使用 args library 可以定义和解析命令行参数。