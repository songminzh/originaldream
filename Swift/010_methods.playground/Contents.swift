import UIKit

/// 在Swift中，方法是与某些特定类型相关联的函数。
/// 类、结构体、枚举都可以定义方法

/// 实例方法是属于某个特定类、结构体或者枚举类型实例的方法。
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

// 实例方法需实例化之后调用
let counter = Counter()
counter.increment()
counter.increment(by: 6)
counter.reset()

// 在实例方法中修改值类型
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var aPoint = Point(x: 1.0, y: 1.0)
aPoint.moveBy(x: 2.0, y: 3.0)
print("Move the point to (\(aPoint.x), \(aPoint.y))")


// 在可变方法中给 self 赋值

enum TriStateSwitch {
    case off, low, high
    mutating func trun() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var light = TriStateSwitch.off
light.trun()
light.trun()

/// 类型方法
/**
 定义在类型本身上调用的方法，这种方法就叫做类型方法。
 在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。
 在方法的 func 关键字之前加上关键字 static，来指定类型方法。
 类还可以用关键字 class 来指定，从而允许子类重写父类该方法的实现。
 */

class MathUtils {
    class func sum(_ numbers: Int...) -> Int {
        var total = 0
        for number in numbers {
            total += number
        }
        
        return total
    }
}

// class关键字修饰的类型方法可以被继承，static不可以，只有类里面的类型方法可以用class关键字修饰，因为只有类能继承
class ma: MathUtils {
    override class func sum(_ numbers: Int...) -> Int {
        print("override the func sum")
        return super.sum()
    }
}

let res = MathUtils.sum(1, 3, 5, 7)
print(res)

// 结构体中的类型方法
struct MathUtilsStruct {
    static func multiply(_ numbers: Int...) -> Int {
        var res = 1
        for number in numbers {
            res *= number
        }
        
        return res
    }
}

print(MathUtilsStruct.multiply(1, 2, 3))
