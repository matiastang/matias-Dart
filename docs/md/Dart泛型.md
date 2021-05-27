<!--
 * @Author: tangdaoyong
 * @Date: 2021-05-27 15:48:24
 * @LastEditors: tangdaoyong
 * @LastEditTime: 2021-05-27 15:51:02
 * @Description: Dart泛型
-->
# Dart泛型

[Dart泛型](https://www.dartcn.com/guides/language/language-tour#%E6%B3%9B%E5%9E%8B)

在 API 文档中你会发现基础数组类型 List 的实际类型是 List<E> 。 <…> 符号将 List 标记为 泛型 (或 参数化) 类型。 这种类型具有形式化的参数。 通常情况下，使用一个字母来代表类型参数， 例如 E, T, S, K, 和 V 等。
限制泛型类型
使用泛型类型的时候， 可以使用 extends 实现参数类型的限制。