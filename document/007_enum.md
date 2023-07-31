
# Swift 枚举

## 定义与用法

```swift
enum testEnum: Int {
    case A = 1
    case B = 2
}
```

```swift
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
```

## 使用枚举

```swift
enum AlphaBeta: CaseIterable {
    case A,B,C
}

for item in AlphaBeta.AllCases.SubSequence() {
    print(item)
}
```

```swift
enum Color: String {
    case red = "FF0000"
    case green = "00FF00"
    case blue = "0000FF"
}

let color = Color.red
```

```swift
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
```

## 递归枚举 算术表达式

```swift
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
```

## 练习

```swift
enum ShapeDimensions {
    // 点 没有关联值，它没有尺寸
    case point
    // 正方形的关联值是边长
    case square(side: Double)
    // 长方形的关联值是宽和高
    case rectangle(width: Double, height: Double)
    // 直角三角形
    case rightTriangle(cathetus1: Double, cathetus2: Double)
    
    // 利用关联值计算面积
    func area() -> Double {
        switch self {
        case .point:
            return 0.0
        case let .square(side: side):
            return side * side
        case let .rectangle(width: w, height: h):
            return w * h
        case let .rightTriangle(cathetus1: c1, cathetus2: c2):
            return (c1 * c2) / 2
        }
    }
    
    // 利用关联值计算周长
    func perimeter() -> Double {
        switch self {
        case .point:
            return 0.0
        case let .square(side: side):
            return 4 * side
        case let .rectangle(width: width, height: height):
            return 2 * (width + height)
        case let .rightTriangle(cathetus1: c1, cathetus2: c2):
            let hypotenuse = sqrt(c1*c1 + c2*c2)
            return (c1 + c2) + hypotenuse
        }
    }
}

var squareShape = ShapeDimensions.square(side: 10.0)
var rectShape = ShapeDimensions.rectangle(width: 5.0, height: 10.0)
var rightTriangle = ShapeDimensions.rightTriangle(cathetus1: 3, cathetus2: 4)
var point = ShapeDimensions.point
print("Square shape's area is \(squareShape.area())")
print("Rect shape's area is \(rectShape.area())")
print("Right triangle's area is \(rightTriangle.area())")
print("Point's area is \(point.area())")
print("Rect shape's preimeter is \(rectShape.perimeter())")
print("Square shape's preimeter is \(squareShape.perimeter())")
print("Right triangle's preimeter is \(rightTriangle.perimeter())")
print("Point's preimeter is \(point.perimeter())")
```