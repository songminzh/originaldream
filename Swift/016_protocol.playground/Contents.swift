import UIKit

/// 协议
/**
 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。
 类、结构体或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。
 某个类型能够满足某个协议的要求，就可以说该类型遵循这个协议。
 使用协议可以使代码更加灵活，可扩展性更高，并促进代码的复用。
 */

/// 定义
protocol EatProtocol {}
protocol PlayProtocol {}

struct People: EatProtocol, PlayProtocol {} // 遵循多个协议，中间用逗号隔开

class Animal {}
class Bird: Animal, EatProtocol, PlayProtocol {} // 子类遵循协议，需将协议名写在父类的后面用逗号隔开

/// 属性要求
/**
 协议不仅可以声明方法要求，还可以声明属性要求。
 属性要求可以是可读的或可读写的。
 实现该协议的类型必须提供对应的属性并满足要求。
 */
protocol Nameable {
    var name: String { get }
}

struct SomeS: Nameable {
    var name: String
    
    let dd = 0
    
    func showName() {
        print("the name is \(self.name)")
    }
}

let ss = SomeS(name: "Haland")
ss.showName()

/// 方法要求
/**
 协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。
 这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。
 可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法提供默认参数。
 */
protocol GrowFlowersProtocol {
    static func watering(_ times: Int)
    static func fertilize()
    func harvest() -> Double
}

struct GrowPeach: GrowFlowersProtocol {
    static func watering(_ times: Int) {
        print("watering the peach")
    }
    
    static func fertilize() {
        print("fertilize the peach")
    }
    
    func harvest() -> Double {
        let fruit = 9.9
        print("Harvest the fruit: \(fruit) kg")
        return fruit
    }
}

/// 构造器要求
// 协议可以要求遵循协议的类型实现指定的构造器，在协议中只需要定义构造器而无需实现。

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
// 这里使用 required 修饰符可以确保所有子类也必须提供此构造器实现，从而也能遵循协议。

/// 协议作为类型

// 协议可以作为变量、常量、函数参数、返回、数组元素、字典元素以及可选型类型
protocol Printable {
    func printSomething()
}

struct MyStruct: Printable {
    let desc: String
    
    func printSomething() {
        print("\(self.desc)")
    }
}

var pao: Printable = MyStruct(desc: "Printable object")
pao.printSomething()

func aFunction(param: Printable) -> Printable {
    return pao
}

var aArr: [Printable] = []
var optionalValue: Printable?

/// 委托模式（Delegate Pattern）
// 委托模式的实现可以参考 UITableViewDelegate 和 UITableViewDataSource

/// 协议扩展
// 协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。这种实现是默认实现，可以被遵循协议的类型自定义重写
extension Printable {
    func printSomething() {
        print("the default print")
    }
}

class MyClass: Printable {
    
}
let aaa = MyClass()
aaa.printSomething()
// 这里的printSomething()会执行协议扩展中的默认实现

