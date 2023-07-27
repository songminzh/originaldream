import UIKit

/// 属性——将值与特定的类、结构体或枚举关联

/// 存储属性是类、结构体或枚举的一部分，用于存储和检索特定的值
struct FixedLengthRange {
    var firstValue: Int = 0
    let length: Int = 0
    
    init(firstValue: Int, length: Int) {
        self.firstValue = firstValue
    }
}

var ra = FixedLengthRange(firstValue: 0, length: 4)
ra.firstValue = 9

/// 延迟加载（懒加载）属性-lazy
class DataImporter {
    /*
    DataImporter 是一个负责将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data: [String] = []
    // 这里会提供数据管理功能
}

// DataImporter 实例的 importer 属性还没有被创建
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

// DataImporter 实例的 importer 属性现在被创建了
print(manager.importer.fileName)

/// 计算属性 getter setter
/// 运算属性是一种特殊类型的属性
/// 它们不直接存储值，而是通过getter和setter方法来计算属性的值。
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

/// 属性观察器 willSet didSet
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("将 totalSteps 的值设置为 \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("增加了\(totalSteps - oldValue)步")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 300
stepCounter.totalSteps = 998

/// 全局变量和局部变量
// 全局变量是在函数、方法、闭包或任何类型之外定义的变量。
// 局部变量是在函数、方法或闭包内部定义的变量。

/// 属性包装器 @propertyWrapper
/// 是一种强大的特性，允许开发者在属性的访问和修改过程中添加自定义的逻辑。
/// 通过属性包装器，我们可以简化属性的定义和管理，并在属性访问时执行额外的代码。
@propertyWrapper
struct Capitalized {
    private(set) var value = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.capitalized }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

struct Person {
    @Capitalized var name: String
}

var person = Person(name: "alex")
print(person.name)
person.name = "ali"
print(person.name)
// Capitalized 是一个属性包装器，它将存储的字符串值始终以大写字母形式呈现。
// 通过在 name 属性前添加 @Capitalized，我们可以保证 name 属性的值始终为大写形式，无论是在初始化时还是在后续修改时。


/// 类型属性
// 使用关键字 static 来定义类型属性。
// 在类中，可以改用 class 来修饰类型属性

struct SomeStructure {
    let notClassProperty = 0
    static var storedTypeProperty = "Some vlaue"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnum {
    static var storedTypeProperty = "Some vlaue"
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 66
    }
    
    class var overrideableComputedTypeProperty: Int {
        return 111
    }
}

// 类型属性是通过类型本身来访问，而不是通过实例。(通过实例无法访问类型属性)

print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value"
print(SomeStructure.storedTypeProperty)

print(SomeEnum.computedTypeProperty)
print(SomeClass.computedTypeProperty)

struct AudioChannel {
    static let thressholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thressholdLevel {
                // 将当前音量限制在阈值之内
                currentLevel = AudioChannel.thressholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // 存储当前音量作为新的最大输入音量
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 15
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

/// 下标属性 subscript
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
threeTimesTable[6]

// 下标可以接受任意数量的入参，并且这些入参可以是任何类型。
// 下标的返回值也可以是任意类型。
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[1, 0] = 1.5
matrix[0, 1] = 1.2
print(matrix.grid)
