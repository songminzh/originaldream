import UIKit

/// 函数

/// 定义

// 无参无返回值
func donothing() {}

// 有参无返回值
func greet(name: String) {
    print(name)
}

/// 指定参数标签
func greet1(outName name: String) {
    print(name)
}
greet1(outName: "Tylor")

// 忽略参数标签（外部参数）无返回值
func greet2(_ name: String) {
    print(name)
}

// 有参有返回值
func add(a: Int, b: Int) -> Int {
    return a + b
}

// 多重返回值（元组）
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for item in array[1..<array.count] {
        if item < currentMin {
            currentMin = item
        } else if item > currentMax {
            currentMax = item
        }
    }
    
    return (currentMin, currentMax)
}

// 可选元组返回类型
func getMinMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    
    var currentMin = array[0]
    var currentMax = array[0]
    for item in array[1..<array.count] {
        if item < currentMin {
            currentMin = item
        } else if item > currentMax {
            currentMax = item
        }
    }
    
    return (currentMin, currentMax)
}

if let bounds = getMinMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
let mm: (min: Int, max: Int) = minMax(array: [2, 3, 5, 9, 11, 10, 6])
print("min: \(mm.min), max: \(mm.max)")

// 隐式返回的函数
// 如果一个函数的整个函数体是一个单行表达式，这个函数可以隐式地返回这个表达式。
func greeting(for person: String) -> String {
    "Hello" + person + "!"
}

/// 调用
donothing()
greet(name: "Alex")
greet2("Alex")
add(a: 1, b: 2)

/// 函数参数

// 默认参数
func sayHello(name: String = "Swift") {
    print("Hello \(name)")
}
sayHello()
sayHello(name: "World")

// 可变参数，参数可数不定，在函数内可以把可变参数当做Array处理
func sum(numbers: Int...) -> Int {
    var sum = 0
    for item in numbers {
        sum = sum + item
    }
    
    return sum
}
sum(numbers: 1, 3, 5, 7, 9)

// 输入输出参数，inout关键字可以让外部参数被函数修改，可以理解为传入了引用类型（而不是值类型）
func swap2Ints(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}
var num_1 = 5
var num_2 = 6
print("number 1: \(num_1), number 2: \(num_2)")
swap2Ints(&num_1, &num_2)
print("number 1: \(num_1), number 2: \(num_2)")

/// 类型

// 函数类型声明，是Swift中将函数类型定义为一种特定的类型，以便可以将函数作为参数

typealias opera = (Int, Int) -> Int
var a = (Int, String) -> Void

func multiply(a: Int, b: Int) -> Int {
    return a * b
}

func applyOpration(a: Int, b: Int, operation: opera) -> Int {
    return operation(a, b)
}


applyOpration(a: 1, b: 2, operation: add)
applyOpration(a: 1, b: 2, operation: multiply)
