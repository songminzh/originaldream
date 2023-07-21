import UIKit

// 枚举
enum testEnum: Int {
    case A = 1
    case B = 2
}

enum MyEnum {
    case name(String)
    case age(Int)
    case xy(Int, Int)
}

func play(param: MyEnum) {
    switch param {
    case MyEnum.name("Hello"):
        print("Hello")
    case MyEnum.age(10):
        print("Age is 10")
    case MyEnum.xy(100, 200):
        print("100, 200")
    default:
        print("无匹配值")
    }
}


play(param: MyEnum.name("Hello"))
play(param: MyEnum.age(19))

enum AlphaBeta: CaseIterable {
    case A,B,C
}

for item in AlphaBeta.AllCases.SubSequence() {
    print(item)
}

enum Color: String {
    case red = "FF0000"
    case green = "00FF00"
    case blue = "0000FF"
}

let color = Color.red

