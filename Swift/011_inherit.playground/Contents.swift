import UIKit

/// 继承
/**
 一个类可以继承另一个类的属性、方法和其它特性。
 当一个类继承其它类时，继承类叫子类，被继承类叫父类（或超类）。
 在 Swift 中，只有类可以继承，继承是区分类与其它类型的一个基本特征。
 */

/// 定义和声明

// 父类（基类）
class Animal {
    var species: String
    var description: String {
        return "Animal is human's fridends"
    }
    
    init(species: String) {
        self.species = species
    }
    
    func makeSound() {
        print("\(self.species) make sound: 咩咩咩~~~")
    }
}

class Goat: Animal {}

let goat = Goat(species: "Goat")
goat.makeSound()

// 子类继承了父类的属性species和方法init() & makeSound(）
// 注意，Swift中只能单一继承

/// 继承与重写
class Dog: Animal {
    var name: String = "Teddy" {
        didSet {
            print("\(self.species) has a new name:\(name)")
        }
    }
    
    override var description: String {
        return super.description + "\nEvery body loves dog"
    }
    
    override init(species: String) {
        super.init(species: species)
        print("\(self.name) is a \(species)")
    }
    
    override func makeSound() {
        print("\(self.species) make sound: 汪汪汪~~~")
    }
    
    func eat() {
        print("\(self.name) eats meat")
    }
}

class Cat: Animal {
    let name: String = "Tom"
    
    override init(species: String) {
        super.init(species: species)
        
        print("\(self.name) is a \(species)")
    }
    
    override func makeSound() {
        print("\(self.species) make sound: 喵喵喵~~~")
    }
    
    func eat() {
        print("\(self.name) eats fish")
    }
}

print()
let myDog = Dog(species: "Border Collie")
print(myDog.description)
myDog.makeSound()
print()
myDog.name = "Jay"
myDog.eat()

print()
let myCat = Cat(species: "British Shorthair")
print(myCat.description)
myCat.makeSound()
myCat.eat()
print()

// 这里Dog和Cat都继承自Animal，在子类中，可以重写父类的属性和方法，并且新增自己的属性和方法
// 访问控制规则适用于继承关系，子类不能访问父类中被声明为私有（private）的成员

/// final防止被重写
/**
 你可以通过把方法，属性或下标标记为 final 来防止它们被重写
 如果class前使用final关键字修饰，则该类不可被继承
 类型检查和类型转换
 */
var aAnimal: Animal = Dog(species: "Huskies")
if aAnimal is Dog {
    print("\(aAnimal.species) is Dog")
    // aAnimal.name = ""
    // aAnimal.eat()
    // 以上两次会编译错误，类型定义时为父类，无法访问子类的属性或方法
}

if let dogLike = aAnimal as? Dog {
    // 强制转换成子类，即可调用子类属性和方法
    dogLike.eat()
}
print()

/// 多态
/**
 多态性建立在继承关系之上，是继承的一种体现。
 多态性允许我们使用父类类型的引用或指针来引用子类对象，并根据实际运行时所引用的具体子类对象来调用相应的方法。
 */
let animals: [Animal] = [Goat(species: "goat"), Dog(species: "dog"), Cat(species: "cat")]
for animal in animals {
    animal.makeSound()
}

// 通过多态性，我们可以使用父类类型的引用来处理不同类型的子类对象，并根据实际运行时所引用的具体子类对象来调用相应的方法。
// 这样可以使代码更灵活、可扩展，并且更符合面向对象编程的原则。
