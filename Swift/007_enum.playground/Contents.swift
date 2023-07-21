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

enum Shape {
    case circle(radius: Double)
    case square(side: Double)
    case rectangle(width: Double, height: Double)
}

let shape = Shape.circle(radius: 10)

switch shape {
case .circle(let radius):
    print("The circle's radius is \(radius)")
case .square(let side):
    print("The square's side is \(side)")
case .rectangle(let width, let height):
    print("The rectangle's width is \(width) and height is \(height)")
}

// 递归枚举 算术表达式
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let a, let b):
        return evaluate(a) + evaluate(b)
    case .multiplication(let a, let b):
        return evaluate(a) * evaluate(b)
    }
}

let expression = ArithmeticExpression.addition(
    .number(2),
    .multiplication(
        .number(3),
        .number(4)
    )
)

print(evaluate(expression))


