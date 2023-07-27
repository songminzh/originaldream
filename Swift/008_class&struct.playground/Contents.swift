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
