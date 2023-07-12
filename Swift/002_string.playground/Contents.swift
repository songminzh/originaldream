import UIKit

// 1.创建
let str1 = "Hello Swift!"
let str2 = String("Hello Swift!")

// 2.拼接
let str3 = "🐦"
let conbinedStr = str1 + str3

// 3.插值
let name = "Alan"
let age = 19
let msg = "My name is \(name), I‘m \(age) years old"

// 4.长度和访问
let len = str1.count
let firstChar = str1[str1.startIndex] // 获取第一个字符
let lastChar = str1[str1.index(before: str1.endIndex)] // 获取最后一个字符

// 5.比较 == != > < <= >=
let apple = "apple"
let banana = "banana"
if apple == banana {
    print("\(apple) = \(banana)")
}

if apple < banana {
    print("\(apple) > \(banana)")
}

// 6.拆分
let prefix = str1.prefix(4)
let suffix = str1.suffix(4)
let withoutFirst = str1.dropFirst() // 去掉第一个字符
let withoutLast = str1.dropLast() // 去掉最后一个字符



