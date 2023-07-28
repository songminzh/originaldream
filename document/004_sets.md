# 集合类型 Array Set Dictionary

## Array（有序集合）

### 创建

```swift
var a = [1, 2, 3]
print(a)

var b: [String] = ["Tom", "Jeck", "Leo"]
print(b)

var c: Array<Double> = [1.1, 3.5, 5, 7]
print(c)

print(c[0])

var array = Array(repeating: -1, count: 3)
print(array)

var array2 = Array<Int>([1, 2, 4])
```

### 增

```swift
var arr = [Int]() // 便利构造器
arr.append(1)
arr.append(2)
arr = arr + [3, 4, 5]
print(arr)
```

### 删

```swift
arr.remove(at: 1)
print(arr)
```

### 改

```swift
arr[2] = 6
var mulArr = ["how", "are", "you"]
mulArr.replaceSubrange((0...2), with: ["I", "am", "fine"])
print(mulArr)
```

### 查

```swift
print(arr[1])
let item = arr.index(before: 2)
print(item)
```

### 遍历

```swift
for element in arr {
    print("for-element: \(element)")
}

arr.forEach { elem in
    print("for-each-elem: \(elem)")
}
```

### 排序

```swift
arr.sorted()
print("顺序排列: \(arr)")
print(arr)

var reverseArr = Array(arr.reversed())
print("倒序排列: \(reverseArr)")
```

## Set（无序集合，不可元素重复）

### 创建

```swift
var set1: Set = [1, 3, 5, 7]
print(set1)

var set2: Set<String> = ["apple", "orange", "banana"]
print(set2)

let set3: Set<Int> = []
print(set3)

var set4 = Set<String>(["FCB", "MU", "MC"])
```

### 元素操作

```swift
set2.insert("pear")
set2.remove("orange")
if set2.contains("banana") {
    print("set2 contains banana")
}
```

### 集合操作（交集、并集、差集、对称差集）

```swift
let set_1: Set<Int> = [1, 3, 5, 7]
let set_2: Set<Int> = [7, 8, 9]
let intersection = set_1.intersection(set_2) // 交集
print("交集：\(intersection)")
let union = set_1.union(set_2) // 并集
print("并集：\(union)")
let diff = set_1.subtracting(set_2) // 差集
print("差集：\(diff)")
let symmetricDiff = set_1.symmetricDifference(set_2) // 对称差集
print("对称差集：\(symmetricDiff)")
```

### 遍历

```swift
for elem in set2 {
    print("item: \(elem)")
}
```

### 计数与判断

```swift
let count = set2.count // 元素个数
let isEmpty = set2.isEmpty // 是否为空
```

### 过滤

```swift
let set_3 = [1, 2, 3, 4, 5]
let filterSet = set_3.filter { elem in
    return elem % 2 == 0
}
print(filterSet)
```

## Dictionary

### 创建

```swift
var dict1: Dictionary<String, String> = ["a": "A", "b": "B", "c": "C"]
var dict2 = ["success": 1, "error": -1]
```

### 访问和修改

```swift
let value = dict1["b"]
dict1["a"] = "AAA"
dict1["d"] = "D"
dict1.updateValue("E", forKey: "e")
print(dict1)
```

### 遍历

```swift
for (key, value) in dict1 {
    print("key: \(key), value: \(value)")
}

for key in dict1.keys {
    print("key: \(key)")
}

for value in dict1.values {
    print("value: \(value)")
}
```

### 判断是否包含

```swift
let isContain = dict1.contains { $0.key == "b" }
if isContain {
    print("包含")
}

if dict1.keys.contains("f") {
    print("dict1的键包含f")
} else {
    print("dict1的键不包含f")
}

if dict1.values.contains("D") {
    print("dict1的值包含D")
} else {
    print("dict1的值不包含D")
}
```

### 过滤

```swift
let filterDict = dict1.filter { (key, value) in
    return value.count == 1
}
print(filterDict)
```

以上是 Swift 中的集合类型：Array、Set 和 Dictionary 的基本用法。它们分别用于存储有序集合、无序集合和键值对集合，提供了丰富的操作方法和功能。