
# 扩展（Extensions）概述

扩展是一种在 Swift 中为现有的类、结构体、枚举以及协议添加新功能的方式。它具有以下特点：

- 扩展允许我们在不访问原始源码的情况下为类型添加功能。
- 类似于 Objective-C 中的分类（Categories），但不同的是，扩展没有名称。

## 添加计算属性和方法

我们可以通过扩展来为类型添加新的计算属性和方法。下面是一个使用 Double 类型的扩展的例子：

```swift
extension Double {
    var m: Double { return self }
    var km: Double { return self * 1_000.0 }
    // ... 其他单位的计算属性
    func toInt() -> Int {
        return Int(self)
    }
}
```

这个扩展为 Double 类型添加了一些单位的计算属性和一个将 Double 转换为 Int 的方法。

## 添加新的初始化方法

扩展还可以为类型添加新的初始化方法。例如，下面是一个为 String 类型添加的初始化方法的示例：

```swift
extension String {
    init(repeating character: Character, count: Int) {
        self = String(repeating: character, count: count)
    }
}
```

这个扩展让我们可以使用一个字符和重复次数来创建一个新的字符串。

## 遵循协议

我们可以通过扩展来让类型遵循协议。下面是一个为 Int 类型遵循 Printable 协议的示例：

```swift
protocol Printable {
    var desc: String { get }
}

extension Int: Printable {
    var desc: String {
        return "the integer value is \(self)"
    }
}
```

这个扩展使得 Int 类型可以通过 desc 属性提供其描述信息。

## 为嵌套类型添加扩展

如果一个类型包含嵌套类型，我们可以通过扩展为嵌套类型添加功能。以下是一个示例，为 MyStruct 的嵌套类型 InnerEnum 添加了一个方法：

```swift
struct MyStruct {
    enum InnerEnum {
        case value1
        case value2
        // ... 其他值
    }
    // ...
}

extension MyStruct.InnerEnum {
    func printValue() {
        print("Value of inner enum: \(self)")
    }
}
```

这个扩展使得我们可以调用 InnerEnum 的 printValue 方法。

## 限制扩展类型的应用范围

扩展的应用范围可以通过 where 关键字进行限制。下面是一个示例，限制了 Collection 中元素为 Equatable 的扩展的应用范围：

```swift
extension Collection where Element: Equatable {
    func containsElement(_ element: Element) -> Bool {
        return self.contains(element)
    }
}
```

这个扩展为遵循 Equatable 协议的元素类型的集合添加了一个方法，用于检查元素是否存在。
