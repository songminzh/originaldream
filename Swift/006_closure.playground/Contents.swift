import UIKit

/// 闭包
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames 为 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

// 从繁到简过程如下

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in s1 > s2 })

reversedNames = names.sorted(by: { (s1, s2) -> Bool in s1 > s2 })

reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

reversedNames = names.sorted(by: { $0 > $1 } )

reversedNames = names.sorted(by: >)

// 闭包作为参数
func operateOnNumbers(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

let addClosure:(Int, Int) -> Int = { (a, b) in
    return a + b
}

let result = operateOnNumbers(a: 2, b: 3, operation: addClosure)


// 闭包作为返回值
func makeIncrementer(incrementAmount: Int) -> ( () -> Int ) {
    var total = 0
    let increamentClosure:() -> Int = {
        total += incrementAmount
        return total
    }
    
    return increamentClosure
}

let incrementBy2 = makeIncrementer(incrementAmount: 2)
let res = incrementBy2()
incrementBy2()
print(res)


// 尾随闭包
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}

print("string by numbered:\(strings)")
// 值捕获 在嵌套函数中，函数的返回值可以是一个函数，内部函数可以捕获外部函数的值
func makeIncrementer(forIncrement amount: Int) -> ( ()->Int ) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

// 闭包是引用类型
// 无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引用。


// 逃逸闭包
// 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
   
// 自动闭包
// 自动闭包（Autoclosures）是一种特殊的闭包类型，它可以延迟求值，并且在需要时自动创建

func printRes(_ closure: @autoclosure () -> Void ) {
    print("Before")
    closure()
    print("After")
}

printRes(print("hahahaha"))
