import UIKit

var welcomeMessage : String

welcomeMessage = "Hello"

// 可选型（optionals）： ？
var opStr : String? = ""
opStr = "🤗🤗🤗"

// 强制解包（Forced Unwrapping）： ！
if opStr != nil {
    print("Give you \(opStr!)")
}

// 可选绑定: if let
var optionsalValue: Int? = 11
if let unwrappedValue = optionsalValue {
    print("this value is \(unwrappedValue)")
} else {
    print("The optional value is nil")
}

var a: String? = nil
if let value = a {
    print("value:\(value)")
} else {
    print("a没有值")
}

// 隐式解析可选类型
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号
print(implicitString)

// 错误处理 do-try-catch
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

// 断言
// assert(_:_:file:line:)
let age = 11
assert(age >= 0, "A person's age cannot be less than zero")
// assertionFailure(_:file:line:)

// 强制执行先决条件
//  precondition(_:_:file:line:)
let index = 1
precondition(index > 0, "Index must be greater than zero.")

// 类型别名：
typealias Str = String
let newS: Str = "dada"
print("\(newS)")

// 空和运算符： ？？
opStr = nil
let haha = opStr ?? "haha"
print("optional value is \(haha)")

// 元组
var tp = (1, 1.5, "hello", true)
print(tp)
var tp2: (Int, String) = (404, "Not Found")
print("code:\(tp2.0), message:\(tp2.1)")
var tp3 = (name: "Alen", age:18)
print("\(tp3.name), \(tp3.age) years old")

// 基本运算符
// 赋值 =
// 算数 + - * / %
// 比较 > < >= <= == !=
// 三元 A ？B ：C
// 空和 ？？
// 区间 a...b a..<b a... ..<b
// 逻辑 ! && ||

