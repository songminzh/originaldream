# 控制流

## guard

`guard` 语句用于提前退出函数、方法或循环。在 `guard` 语句的 `else` 分支中必须使用 `return`、`throw`、`break` 或者类似的语句来提前退出函数、方法或循环，而不是继续执行后续的代码。

```swift
func dosome() {
    var b: String? = nil
    guard let a = b else {
        return
    }
    
    print("a = \(a)")
}

dosome()
```

```swift
func processUser(age: Int?) {
    guard let userAge = age else {
        print("未提供年龄信息")
        return
    }
    
    guard userAge >= 18 else {
        print("用户未成年，无法完成操作")
        return
    }
    
    print("用户年龄符合要求，可以进行下一步操作")
    // do next step
}

processUser(age: 17)
```

## switch case

`switch case` 语句用于根据不同的条件执行不同的代码块。

```swift
var code = 404
switch code {
case 404:
    print("Not Found")
case 500:
    print("Server error")
default:
    print("Unknown error")
}
```

`switch` 的对象可以是任何基本数据类型（`Int`、`String`、元组）。

```swift
var value = (404, "Not Found")
switch value {
case let (code, message):
    print("code: \(code)")
    print("message: \(message)")
    fallthrough
case (404, "Not Found"):
    print("Not Found")
case (500, "Server error"):
    print("Server error")
default:
    print("Unknown error")
}
```

## fallthrough

`fallthrough` 关键字不会检查它下一个将会落入执行的 `case` 中的匹配条件。`fallthrough` 简单地使代码继续连接到下一个 `case` 中的代码。

## continue 和 break

- `continue` 用于跳过本次循环，进入下一次循环。
- `break` 用于跳出整个循环。

```swift
// continue 跳过本次循环，进入下一次循环
for index in 0...10 {
    if index == 2 {
        continue
    }
    
    print(index)
}

// break 跳出整个循环
for index in 0...10 {
    if index == 2 {
        break
    }
    
    print(index)
}
```

## while 循环

```swift
var a = 0
var flag = true
while flag {
    print("while-\(a)")
    
    a = a + 1
    if a > 5 {
        flag = false
    }
}
```

## repeat while 循环

```swift
var a = 0
var flag = true
repeat {
    print("repeat-while-\(a)")
    
    a = a + 1
    if a > 10 {
        flag = false
    }
} while flag
```

以上是 Swift 中的控制流语句，可以根据不同的条件执行不同的代码块或控制程序的流程。