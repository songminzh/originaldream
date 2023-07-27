# 属性 - 将值与特定的类、结构体或枚举关联

属性是用于存储和检索特定值的特性，它们可以被定义在类、结构体和枚举中。
属性的内容包括存储属性、延迟加载属性、计算属性、属性观察器、属性包装器、类型属性和下标属性。

## 存储属性

存储属性用于存储特定类型的值，并将其与类、结构体或枚举关联。

```swift
struct FixedLengthRange {
    var firstValue: Int
    var length: Int
}

var range = FixedLengthRange(firstValue: 0, length: 5)
range.firstValue = 10
print(range.firstValue) // 输出: 10
```

## 延迟加载属性

延迟加载属性在首次访问时才会创建和初始化相关实例，可以用于延迟加载耗时的操作。

```swift
class DataImporter {
    var fileName: String
    // ...
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
}

let manager = DataManager()
manager.data.append("Some data")
print(manager.importer.fileName) // 输出: ""
```

## 计算属性

计算属性通过 getter 和 setter 方法计算属性值，而不是直接存储值。

```swift
struct Point {
    var x: Double
    var y: Double
}

struct Size {
    var width: Double
    var height: Double
}

struct Rect {
    var origin: Point
    var size: Size
    var center: Point {
        return Point(x: origin.x + size.width / 2, y: origin.y + size.height / 2)
    }
}

let rect = Rect(origin: Point(x: 0, y: 0), size: Size(width: 100, height: 100))
print(rect.center) // 输出: Point(x: 50.0, y: 50.0)
```

## 属性观察器

属性观察器允许在属性值即将被设置或已经被设置后执行自定义的代码。

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("将 totalSteps 的值设置为 \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("增加了 \(totalSteps - oldValue) 步")
            }
        }
    }
}

let counter = StepCounter()
counter.totalSteps = 10
// 输出:
// 将 totalSteps 的值设置为 10
// 增加了 10 步
```

## 属性包装器

属性包装器提供了一种在属性的访问和修改过程中添加自定义逻辑的方式。

```swift
@propertyWrapper
struct Capitalized {
    private var value: String

    var wrappedValue: String {
        get { value }
        set { value = newValue.capitalized }
    }

    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

struct Person {
    @Capitalized
    var name: String
}

var person = Person(name: "john")
print(person.name) // 输出: "John"
person.name = "jane"
print(person.name) // 输出: "Jane"
```

## 类型属性

类型属性是与类型本身关联的属性，而不是与实例关联的属性。

```swift
struct SomeStructure {
    var notClassProperty: Int
    static var storedTypeProperty: String = "Some value"
    static var computedTypeProperty: Int {
        return 42
    }
}

enum SomeEnum {
    static var storedTypeProperty: String = "Some value"
    static var computedTypeProperty: Int {
        return 42
    }
}

class SomeClass {
    static var storedTypeProperty: String = "Some value"
    static var computedTypeProperty: Int {
        return 42
    }
    class var overrideableComputedTypeProperty: Int {
        return 42
    }
}

print(SomeStructure.storedTypeProperty) // 输出: "Some value"
print(SomeEnum.computedTypeProperty) // 输出: 42
print(SomeClass.overrideableComputedTypeProperty) // 输出: 42
```

## 下标属性

下标属性允许通过索引值来访问集合、列表或序列中的元素。

```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let table = TimesTable(multiplier: 3)
print(table[5]) // 输出: 15

struct Matrix {
    let rows: Int
    let columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }

    subscript(row: Int, column: Int) -> Double {
        get {
            return grid[(row * columns) + column]
        }
        set {
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 0] = 1.0
matrix[0, 1] = 2.0
matrix[1, 0] = 3.0
matrix[1, 1] = 4.0

print(matrix[0, 0]) // 输出: 1.0
print(matrix[1, 1]) // 输出: 4.0
```

以上是属性的不同类型和用法的说明，以及相应的调用示例。这些属性提供了一种便捷的方式来存储和访问特定的值，并且能够根据需要添加自定义的逻辑和行为。