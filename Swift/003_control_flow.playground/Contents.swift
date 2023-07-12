import UIKit

// if else

// switch case
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

// fallthrough 关键字不会检查它下一个将会落入执行的 case 中的匹配条件。fallthrough 简单地使代码继续连接到下一个 case 中的代码。
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

// while
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
// repeat while
repeat {
    print("repeat-while-\(a)")
    
    a = a + 1
    if (a > 10) {
        flag = false
    }
} while (flag)
