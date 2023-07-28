## Swift基础部分

### 可选型（optionals）： ?

```swift
var opStr: String? = ""
opStr = nil
opStr = "🤗🤗🤗"
```

### 强制解包（Forced Unwrapping）： !

```swift
if opStr != nil {
    print("Give you \(opStr!)")
}
```

### 可选绑定: if let 或 guard let
使用可选型绑定后被赋值的对象的类型会自动解包为非可选类型。
```swift
var optionalValue: Int? = 10
if let unwrappedValue = optionalValue {
    print("the type of unwrapped value is")
    print(type(of: unwrappedValue))
    print("this value is \(unwrappedValue)")
} else {
    print("The optional value is nil")
}

var aStr: String? = "ddd"
if let value = aStr {
    print("the type of unwrapped value is")
    print(type(of: value))
    print("value:\(value)")
} else {
    print("a string没有值")
}

func showGuard(str: String?) {
    guard let myValue = str else {
        print("a string has no value")
        return
    }

    print("Show guard function get the value:\(myValue) from optional ")
}
showGuard(str: aStr)
```

### 隐式解析可选类型

```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要强制解包

let assumedString: String! = possibleString
let implicitString: String = assumedString  // 不需要显式解包
print(implicitString)
```

### 错误处理 do-try-catch

```swift
enum CustomError: Error {
    case error1
    case error2
}

func doSomething() throws {
    throw CustomError.error2
}

do {
    try doSomething()
} catch CustomError.error1 {
    print("捕获到error1错误")
} catch CustomError.error2 {
    print("捕获到error2错误")
} catch {
    print("捕获到其他错误")
}
```

### 断言
断言通常用于检查程序中的逻辑错误和不可恢复的错误情况。
一般用于调试和开发阶段发现和修复错误。
```swift
let age = 2
assert(age >= 0, "A person's age cannot be less than zero")
```

### 强制执行先决条件
强制执行先决条件通常用于检查输入参数、确保数据的合法性，以及在运行时处理可恢复的错误情况。
一般用于运行时错误的检查。
```swift
let index = 1
precondition(index > 0, "Index must be greater than zero.")
```

### 类型别名

```swift
typealias Str = String
let newS: Str = "dada"
print("\(newS)")
```

### 空和运算符： ??

```swift
opStr = nil
let haha = opStr ?? "haha"
print("optional value is \(haha)")
```

### 元组

```swift
var tp = (1, 1.5, "hello", true)
print(tp)
var tp2: (Int, String) = (404, "Not Found")
print("code:\(tp2.0), message:\(tp2.1)")
var tp3 = (name: "Alen", age:18)
print("\(tp3.name), \(tp3.age) years old")
```

### 基本运算符

```swift
/**
 赋值 =
 算数 + - * / %
 比较 > < >= <= == !=
 三元 A ? B : C
 空和 ??
 区间 a...b a..<b a... ..<b
 逻辑 ! && ||
 */
```

以上是包含注释的完整Markdown文档。非常抱歉之前的疏忽。