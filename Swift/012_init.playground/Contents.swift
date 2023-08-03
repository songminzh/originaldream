import UIKit

/// 初始化
// 初始化包括构造过程和析构过程
// 我们使用初始化器（构造器）来实现构造过程
// 我们使用析构器来实现析构过程

/// 构造过程
// 构造过程是使用类、结构体或枚举类型的实例之前的准备过程。

/// 普通的初始化器

enum Position {
    case UNKNOWN
    case GK
    case SW
    case DC
    case LB
    case RB
    case DM
    case CM
    case LM
    case RW
    case LW
    case SS
    case CF
}

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

let leo = FootballPlayer(name: "Messi", age: 36, number: 10, position: .CF)

print("\(leo.name)")

/// 可失败的初始化器

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

let onlyGoat = GOAT(name: leo.name)

let aweiluo = GOAT(name: "aweiluo") // 初始化失败

/// 必要的初始化器
/// 父类的以required关键字声明的初始化器，子类必须予以实现

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

/// 结构体的成员初始化器
// 结构体默认会给成员变量生成初始化器，如无自定义内容，可省略结构体的初始化器的声明和实现

struct Car {
    var name: String
    var power: String
}

var tesla = Car(name: "Model S", power: "electric")

print("\(tesla.name) is \(tesla.power) power")

// 闭包设置属性的初始值
// 可以使用闭包为属性设置初始值，在闭包的后面加上()表示立即执行，并将执行后的值赋给属性

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

print("\(Eich.name) use \(Eich.weapon)")
print("This hero has \(Eich.goldCoin) gold corns, and attack is \(Eich.attack)")

// 析构过程 deinit
// 析构过程用于在自动释放资源时进行一些额外的清理，析构器是在实例释放发生前被自动调用的

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        print("deinit is called")
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// 打印“A new player has joined the game with 100 coins”
print("There are now \(Bank.coinsInBank) coins left in the bank")
// 打印“There are now 9900 coins left in the bank”

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// 打印“PlayerOne won 2000 coins & now has 2100 coins”
print("The bank now only has \(Bank.coinsInBank) coins left")
// 打印“The bank now only has 7900 coins left”

playerOne = nil
print("PlayerOne has left the game")
// 打印“PlayerOne has left the game”
print("The bank now has \(Bank.coinsInBank) coins")

// 当实例为nil时，主动调用deinit方法，执行析构过程。
