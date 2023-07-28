

# Swift基础

## 创建

```swift
let str1 = "Hello Swift!"
let str2 = String("Hello Swift!")
```

## 拼接

```swift
let str3 = "🐦"
let combinedStr = str1 + str3
```

## 插值

```swift
let name = "Alan"
let age = 19
let msg = "My name is \(name), I'm \(age) years old"
```

## 长度和访问

```swift
let len = str1.count
let firstChar = str1[str1.startIndex] // 获取第一个字符
let lastChar = str1[str1.index(before: str1.endIndex)] // 获取最后一个字符
```

## 比较

```swift
let apple = "apple"
let banana = "banana"
if apple == banana {
    print("\(apple) == \(banana)")
}

if apple < banana {
    print("\(apple) < \(banana)")
}
```

## 拆分

```swift
let prefix = str1.prefix(4)
let suffix = str1.suffix(4)
// 去掉第一个字符
```
