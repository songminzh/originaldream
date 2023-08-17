# Swift 泛型

Swift 中的泛型功能允许你编写灵活可复用的代码，以适用于各种类型，从而避免了重复编写类似的代码，提高了代码的清晰性和抽象性。

## 泛型函数

泛型函数使得你能够编写适用于任意类型的、可重用的函数。下面是一个用于交换两个值的泛型函数的示例：

```swift
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var a = 9.8
var b = 9.6
swapTwoValues(&a, &b)
print("a: \(a), b: \(b)")  // 输出: a: 9.6, b: 9.8
```

## 泛型类型

除了泛型函数，你还可以定义自己的泛型类型。下面是一个用于实现栈（后进先出）的泛型结构体的示例：

```swift
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() {
        items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
stackOfStrings.pop()
```

## 泛型扩展

你可以通过扩展泛型类型来添加新的功能。下面是一个为栈添加获取顶部元素的泛型扩展的示例：

```swift
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

print("\(stackOfStrings.topItem ?? "")")  // 输出: tres
```

## 泛型约束

你可以对泛型类型参数进行约束，以限制允许的数据类型。下面是一个使用泛型约束来比较两个值是否相等的示例：

```swift
func processItems<T: Equatable>(item1: T, item2: T) -> Bool {
    return item1 == item2
}

processItems(item1: "swift", item2: "Swift")  // 返回 true
```

## 泛型下标

你也可以在泛型类型中定义下标。下面是一个使用泛型下标实现的简单字典结构的示例：

```swift
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
```
