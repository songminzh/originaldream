
# 协议（Protocols）

协议是一种蓝图，用于规定实现特定任务或功能的方法、属性以及其他所需内容。
类、结构体和枚举都可以遵循协议，并为协议中定义的要求提供具体实现。
一个类型如果满足了一个协议的要求，就可以说该类型遵循了这个协议。
使用协议可以增加代码的灵活性、可扩展性，并促进代码的复用。

## 定义协议

协议可以被用来定义一个蓝图，规定了一组需要实现的方法和属性。下面是一些例子：

```swift
protocol EatProtocol {}
protocol PlayProtocol {}

struct People: EatProtocol, PlayProtocol {}

class Animal {}
class Bird: Animal, EatProtocol, PlayProtocol {}
```

## 属性要求

协议不仅可以声明方法要求，还可以声明属性要求。属性要求可以是可读的或可读写的，实现该协议的类型必须提供对应的属性并满足要求。例如：

```swift
protocol Nameable {
    var name: String { get }
}

struct SomeS: Nameable {
    var name: String
    
    func showName() {
        print("名称是 \(self.name)")
    }
}

let ss = SomeS(name: "Haland")
ss.showName()
```

## 方法要求

协议可以要求遵循协议的类型实现特定的实例方法或类方法。这些方法作为协议的一部分，放在协议的定义中，但是不需要方法体。下面是一个例子：

```swift
protocol GrowFlowersProtocol {
    static func watering(_ times: Int)
    static func fertilize()
    func harvest() -> Double
}

struct GrowPeach: GrowFlowersProtocol {
    static func watering(_ times: Int) {
        print("浇水给桃树")
    }
    
    static func fertilize() {
        print("施肥给桃树")
    }
    
    func harvest() -> Double {
        let fruit = 9.9
        print("收获水果：\(fruit) 公斤")
        return fruit
    }
}
```

## 构造器要求

协议可以要求遵循协议的类型实现指定的构造器。在协议中只需要定义构造器的声明，不需要实际实现。例如：

```swift
protocol ContainInitProtocol {
    init(name: String, age: Int)
}

class Student: ContainInitProtocol {
    var name: String
    var age: Int
    
    required init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
```

## 协议作为类型

协议可以作为变量、常量、函数参数、返回值、数组元素、字典元素以及可选类型使用。例如：

```swift
protocol Printable {
    func printSomething()
}

struct MyStruct: Printable {
    let desc: String
    
    func printSomething() {
        print("\(self.desc)")
    }
}

var pao: Printable = MyStruct(desc: "可打印对象")
pao.printSomething()

func aFunction(param: Printable) -> Printable {
    return pao
}

var aArr: [Printable] = []
var optionalValue: Printable?
```

## 委托模式（Delegate Pattern）

委托模式的实现可以参考 `UITableViewDelegate` 和 `UITableViewDataSource` 协议。

## 协议扩展

协议可以通过扩展为遵循协议的类型提供属性、方法以及下标的默认实现，但这些实现可以被遵循协议的类型自定义重写。例如：

```swift
extension Printable {
    func printSomething() {
        print("默认打印方式")
    }
}

class MyClass: Printable {}

let aaa = MyClass()
aaa.printSomething()
```

在上述例子中，`printSomething()` 方法会执行协议扩展中的默认实现。
