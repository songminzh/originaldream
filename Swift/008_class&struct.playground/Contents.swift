import UIKit

/// 类和结构体
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

var vga = Resolution()
let videoMode = VideoMode()

vga = Resolution(width: 640, height: 480)

videoMode.resolution = vga
print("the width of video mode is \(videoMode.resolution.width)")
print("the height of video mode is \(videoMode.resolution.height)")

/// 结构体和枚举是值类型
/// 其值不会因赋值对象的值改变而改变， 仅仅是拷贝而不是引用
var hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("hd's width is \(hd.width)")
print("cinema's width is \(cinema.width)")

/// 类是引用类型
/// 赋值时传递的是引用，赋值对象的值被修改，原值也会跟着被修改
let  tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("ten eighty's frame rate is \(tenEighty.frameRate)")
print("also ten eighty's frame rate is \(alsoTenEighty.frameRate)")

/// 恒等运算符
// 相同（===）
// 不相同（!==）
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

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


/// Any & AnyObject
// Any可以表示任何类型，包括值类型和引用类型
// AnyObject只能表示Class类型的实例

/// 类和结构体的不同点
/**
 1. 类是引用类型，结构体是值类型；
 2. 类支持继承，结构体不支持；
 3. 类的实例在堆上分配，使用ARC进行内存管理，当没有任何强引用指向实例时，内存会被自动释放，结构体的实例在栈上分配，当超出作用域时会自动被销毁；
 4. 类支持类型转换，用于检查和解释类实例的类型，结构体不支持；
 5. 结构体有默认的成员逐一构造器，可以通过将每个属性的值作为参数的初始化函数来创建结构体实例，而类没有，需要手动实现初始化方法；
 6. 可变性，结构体的属性是值类型，所以在结构体的实例上的属性默认是不可变的，除非将实例声明为“var”，而类的属性始终可以修改，即使将实例声明为“let”；
 */
