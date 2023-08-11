import UIKit

/// 扩展

/**
 扩展可以给一个现有的类、结构体、枚举以及协议添加新的功能。
 它还有不需要访问被扩展类型源码就能完成扩展的能力。
 类似于OC的分类，但不同于分类的是，扩展是没有名称的
 */

/// 添加计算属性和方法

// 扩展可以添加新的计算属性，但是它们不能添加存储属性，或向现有的属性添加属性观察者。
extension Double {
    var m: Double { return self }
    var km: Double { return self * 1_000.0 }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_1000.0 }
    var ft: Double { return self / 3.28084 }
    
    func toInt() -> Int {
        return Int(self)
    }
}

print("\(3.1415926.km) meters")

let distance = 1.5.km + 300.m
print("the distance is \(distance.toInt()) meters")

/// 添加新的初始化方法
extension String {
    init(repeating character: Character, count: Int) {
        self = String(repeating: character, count: count)
    }
}

let repeatedStr = String(repeating: "a", count: 6)

/// 遵循协议
protocol Printable {
    var desc: String { get }
}

extension Int: Printable {
    var desc: String {
        return "the integer value is \(self)"
    }
}

let num = 23
let description = num.desc

/// 为嵌套类型添加扩展

struct MyStruct {
    enum InnerEnum {
        case value1
        case value2
        case value3
    }
    
    // ... 这里可以添加 MyStruct 的其他属性和方法
}

extension MyStruct.InnerEnum {
    func printValue() {
        print("Value of inner enum: \(self)")
    }
}

let instance = MyStruct.InnerEnum.value2
instance.printValue()

/// 限制扩展类型的应用范围
extension Collection where Element: Equatable {
    func containsElement(_ element: Element) -> Bool {
        return self.contains(element)
    }
}

let nums = [1, 4, 5, 7, 8]
nums.containsElement(1)



