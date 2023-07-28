import UIKit

/// 控制流

/// guard
/**
 用于提前退出函数、方法或循环
 在 guard 语句的 else 分支中必须使用 return、throw、break 或者类似的语句来提前退出函数、方法或循环，而不是继续执行后续的代码。
 */

func dosome() {
    var b: String? = nil
    guard let a = b else {
        return
    }
    
    print("a = \(a)")
}

dosome()

func processUser(age: Int?) {
    guard let userAge = age else {
        print("未提供年龄信息")
        return
    }
    
    guard userAge >= 18 else {
        print("用户未成年，无法完成操作")
        return
    }
    
    print("用户年龄符合要求，可以进行下一步操作")
    // do next step
}

processUser(age: 17)
    
/// switch case
var code = 404
switch code
{
case 404:
    print("Not Found")
case 500:
    print("Server error")
default:
    print("Unknown error")
}

// switch的对象可以是任何基本数据类型（Int、String、元组）
var value = (404, "Not Found")
switch value
{
    
case let (code, message):
    print("code:\(code)")
    print("message:\(message)")
    fallthrough
case (404, "Not Found"):
    print("Not Found")
case (500, "Server error"):
    print("Server error")
default:
    print("Unknown error")
}

/// fallthrough
/**
 关键字不会检查它下一个将会落入执行的 case 中的匹配条件。
 fallthrough简单地使代码继续连接到下一个 case 中的代码。
 */

// continue 跳过本次循环，进入下一次循环
for index in (0...10)
{
    if index == 2 {
        continue
    }
    
    print(index)
}

// break 跳出整个循环
for index in (0...10)
{
    if index == 2 {
        break
    }
    
    print(index)
}

/// while
var a = 0
var flag = true
while (flag) {
    print("while-\(a)")
    
    a = a + 1
    if (a > 5) {
        flag = false
    }
}

flag = true

/// repeat while
repeat {
    print("repeat-while-\(a)")
    
    a = a + 1
    if (a > 10) {
        flag = false
    }
} while (flag)
