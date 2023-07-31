# 类和结构体

## 结构体和类的定义

```swift
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
```

在上述代码中，我们定义了一个名为`Resolution`的结构体和一个名为`VideoMode`的类。`Resolution`结构体有两个属性`width`和`height`，默认值为0。`VideoMode`类有四个属性`resolution`、`interlaced`、`frameRate`和`name`，其中`resolution`属性的类型是`Resolution`结构体。

## 结构体和枚举是值类型

```swift
var hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048

print("hd's width is \(hd.width)")
print("cinema's width is \(cinema.width)")
```

在上述代码中，我们创建了一个`Resolution`结构体实例`hd`，并将其赋值给`cinema`。然后我们修改了`cinema`的`width`属性的值为2048。由于结构体是值类型，赋值操作会将值进行拷贝，所以`hd`和`cinema`是两个独立的实例，它们的`width`属性值是不同的。

## 类是引用类型

```swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("ten eighty's frame rate is \(tenEighty.frameRate)")
print("also ten eighty's frame rate is \(alsoTenEighty.frameRate)")
```

在上述代码中，我们创建了一个`VideoMode`类实例`tenEighty`，并将其赋值给`alsoTenEighty`。然后我们修改了`alsoTenEighty`的`frameRate`属性的值为30.0。由于类是引用类型，赋值操作会将引用传递，所以`tenEighty`和`alsoTenEighty`引用的是同一个实例，它们的`frameRate`属性值是相同的。

## 恒等运算符

```swift
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
```

在上述代码中，我们使用恒等运算符`===`来判断`tenEighty`和`alsoTenEighty`是否引用同一个实例。如果相同，即它们指向同一个对象，输出"tenEighty and alsoTenEighty refer to the same VideoMode instance."。

## Any和AnyObject

- `Any`可以表示任何类型，包括值类型和引用类型。
- `AnyObject`只能表示类类型的实例。

## 类和结构体的不同点

1. 类是引用类型，结构体是值类型。
2. 类支持继承，结构体不支持。
3. 类的实例在堆上分配，使用ARC进行内存管理，当没有任何强引用指向实例时，内存会被自动释放，结构体的实例在栈上分配，当超出作用域时会自动被销毁。
4. 类支持类型转换，用于检查和解释类实例的类型，结构体不支持。
5. 结构体有默认的成员逐一构造器，可以通过将每个属性的值作为参数的初始化函数来创建结构体实例，而类没有，需要手动实现初始化方法。
6. 可变性，结构体的属性是值类型，所以在结构体的实例上的属性默认是不可变的，除非将实例声明为`var`，而类的属性始终可以修改，即使将实例声明为`let`。