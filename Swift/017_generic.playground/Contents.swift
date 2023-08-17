import UIKit

/// 泛型
// 泛型代码让你能根据自定义的需求，编写出适用于任意类型的、灵活可复用的函数及类型。
// 你可避免编写重复的代码，而是用一种清晰抽象的方式来表达代码的意图。

/// 泛型函数
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var a = 9.8
var b = 9.6
swapTwoValues(&a, &b)
print("a : \(a), b: \(b)")

// 泛型类型

// 除了泛型函数，Swift 还允许自定义泛型类型。
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() {
        items.removeLast()
    }
}
// 以上，利用泛型构建了一个结构体用于实现栈（后进先出）
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// 栈中现在有 4 个字符串
stackOfStrings.pop()

/// 泛型扩展

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

print("\(stackOfStrings.topItem ?? "")")

/// 泛型约束

// 可以对泛型类型参数进行约束，以限制允许的数据类型
func processItems<T: Equatable>(item1: T, item2: T) -> Bool {
    return item1 == item2
}

processItems(item1: "swift", item2: "Swift")

/// 泛型下标

struct GenericDictionary<Key: Hashable, Value> {
    private var data: [Key: Value] = [:]
    
    subscript(key: Key) -> Value? {
        get {
            return data[key]
        }
        set {
            data[key] = newValue
        }
    }
}

var dict: GenericDictionary = GenericDictionary<String, Any>()
dict["ios"] = "swift"




