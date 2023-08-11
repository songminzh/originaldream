
# 可选链式调用

可选链式调用是一种可以在当前值可能为 nil 的可选值上请求和调用属性、方法及下标的方法。它是一种安全地处理可能为 nil 的可选值的方式。多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为 nil，整个调用链都会失败，即返回 nil，不会引发运行时错误。

## 替代强制解包

```swift
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
```

如果 `residence` 为 nil，则整个可选链式调用会返回 nil，而不会引发运行时错误。

## 调用属性、方法、下标

### 调用方法

```swift
extension Residence {
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
}

john.residence?.printNumberOfRooms()
```

### 调用下标

```swift
if let room = john.residence?.rooms?[0] {
    print("The person has a room: \(room)")
} else {
    print("The person has no room")
}
```

## 避免调试问题

为了避免因可选链式调用带来的调试问题，你可以采用以下方式进行优化处理：

- 使用可选绑定：

```swift
func getGrade(_ student: Student) {
    guard let firstGrade = student.grades?.first else {
        print("The student has no grades")
        return
    }

    print("The student's first grade is \(firstGrade)")
}

getGrade(student)
```

- 使用空合运算符：

```swift
let grade = student.grades?.first ?? 0
```

- 使用断言：

```swift
assert(student.grades != nil, "Student's grades should not be nil!")
let firstG = student.grades!.first
```

这些方法能够在保持代码安全的同时，更好地处理和调试可选链式调用中的可能的 nil 值情况。
