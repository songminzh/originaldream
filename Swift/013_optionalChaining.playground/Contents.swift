import UIKit

/// 可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。
/**
 语法：在可选值后面加上问号（?）来表示。
 是一种安全地处理可能为nil的可选值的方式。
 多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为 nil，整个调用链都会失败，即返回 nil，不会引发运行时错误。
 */


/// 代替强制解包

class Residence {
    var numberOfRooms = 1
    var rooms: [String]?
}

class Person {
    var residence: Residence?
}

let john = Person()
john.residence = Residence()
let roomCount = john.residence!.numberOfRooms

if let roomC = john.residence?.numberOfRooms {
    print("John's residence has \(roomC) rooms")
} else {
    print("Unable to retrieve the number of rooms")
}
// 如果residence为nil，则整个可选链式调用会返回nil，而不会引发运行时错误。

/// 调用属性、方法、下标

// 调用方法
extension Residence {
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
}

john.residence?.printNumberOfRooms()

// 调用下标
if let room = john.residence?.rooms?[0] {
    print("the person has a room:\(room)")
} else {
    print("the person has no room")
}

/// 避免因可选链式调用带来的调试问题，可以采用可选绑定、空和运算符、断言等方式进行优化处理

class Student {
    var name: String
    var age: Int
    var grades: [Int]?

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let student = Student(name: "Alex", age: 18)
print("student name:\(student.name), age:\(student.age), grades:\(student.grades?.count ?? 0)")


// 使用可选绑定
func getGrade(_ student: Student) {
    guard let firstGrade = student.grades?.first else {
        print("the student has no grades");
        return
    }

    print("the student's first grade is \(firstGrade)")
}

getGrade(student)

// 使用空和运算符
let grade = student.grades?.first ?? 0

// 使用断言
assert(student.grades != nil, "Student' grage should not be nil!")
let firstG = student.grades!.first




