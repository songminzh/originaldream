## Swift 中的初始化

### 简介

初始化是在使用类、结构体或枚举类型的实例之前的准备过程。它包括构造实例和设置其初始状态。在 Swift 中，我们使用初始化器（构造器）来实现初始化过程。此外，我们还可以使用析构器来在实例被释放时执行清理任务。

### 普通的初始化器

在提供的代码中，我们定义了一个名为 `FootballPlayer` 的类和一个名为 `Position` 的枚举。`FootballPlayer` 类具有普通的初始化器，用于初始化属性 `name`、`age`、`number` 和 `position`。

```swift
class FootballPlayer {
    var name: String
    var age: Int?
    var number: Int?
    var position: Position?

    init(name: String, age: Int, number: Int, position: Position) {
        self.name = name
        self.age = age
        self.number = number
        self.position = position
    }

    // 自定义初始化器（便利构造器）
    convenience init(name: String) {
        self.init(name: name, age: 0, number: 0, position: .UNKNOWN)
    }
}
```

### 可失败的初始化器

`GOAT` 类有一个可失败的初始化器，通过在 `init` 后面加上问号来标识。它返回该类的可选实例，如果初始化失败，返回 `nil`。

```swift
class GOAT {
    var name: String

    init?(name: String) {
        if name != "Messi" {
            print("Goat 只有一个，\(name)不配")
            return nil
        }

        self.name = name

        print("the only goat is \(name)")
    }
}
```

### 必要的初始化器

父类的以required关键字声明的初始化器，子类必须予以实现。

```swift
class Tree {
    var name: String

    required init(name: String) {
        self.name = name
    }
}

class Cherry: Tree {
    required init(name: String) {
        super.init(name: name)
    }
}
```

### 结构体的成员初始化器

结构体默认会给成员变量生成初始化器，如无自定义内容，可省略结构体的初始化器的声明和实现。
```swift
struct Car {
    var name: String
    var power: String
}

var tesla = Car(name: "Model S", power: "electric")
```

### 使用闭包为属性设置初始值

可以使用闭包为属性设置初始值，在闭包的后面加上()表示立即执行，并将执行后的值赋给属性。


在 `Hero` 结构体中，使用闭包为属性 `name`、`weapon`、`goldCoin` 和 `attack` 设置初始值。

```swift
struct Hero {
    var name = { "hero" }()
    var weapon = {
       "weapon"
    }()
    var goldCoin = {
        0
    }()
    var attack = {
        let a = 10
        let b = 80
        return a + b
    }()

    init(name: String, weapon: String, goldCoin: Int, attack: Int) {
        self.name = "Hero " + name
        self.weapon = weapon
        self.goldCoin = goldCoin * 100
        self.attack = attack + 20
    }
}

let Eich = Hero(name: "Ice shooter", weapon: "🏹", goldCoin: 128, attack: 99)
```

### 析构过程 (deinit)

析构过程用于在自动释放资源时进行一些额外的清理，析构器是在实例释放发生前被自动调用的。

`Bank` 和 `Player` 类演示了 Swift 中的析构过程。`Player` 类中的 `deinit` 块在实例被释放时调用，允许我们执行清理任务。

```swift
class Bank {
    // ...

    deinit {
        print("deinit is called")
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
// ...
playerOne = nil
// ...
```

当将 `playerOne` 实例设置为 `nil` 时，`deinit` 块被调用，释放任何资源并执行必要的清理操作。