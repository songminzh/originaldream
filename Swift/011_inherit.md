
# 继承

一个类可以继承另一个类的属性、方法和其他特性。
继承类叫做子类，被继承类叫做父类（或超类）。
在 Swift 中，只有类可以继承，继承是区分类与其他类型的一个基本特征。

## 定义和声明

```swift
// 父类（基类）
class Animal {
    var species: String
    var description: String {
        return "Animal is human's friends"
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
```

子类继承了父类的属性 `species` 和方法 `init()` 和 `makeSound()`。
**注意，Swift中只能单一继承**

## 继承与重写

```swift
class Dog: Animal {
    var name: String = "Teddy" {
        didSet {
            print("\(self.species) has a new name: \(name)")
        }
    }
    
    override var description: String {
        return super.description + "\nEverybody loves dog"
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

let myDog = Dog(species: "Border Collie")
print(myDog.description)
myDog.makeSound()
myDog.name = "Jay"
myDog.eat()

let myCat = Cat(species: "British Shorthair")
print(myCat.description)
myCat.makeSound()
myCat.eat()
```

在子类中，可以重写父类的属性和方法，并且新增自己的属性和方法。
访问控制规则适用于继承关系，子类不能访问父类中被声明为私有（`private`）的成员。

## final 防止被重写

你可以通过把方法、属性或下标标记为 `final` 来防止它们被重写。
如果在类前使用 `final` 关键字修饰，则该类不可被继承。

## 类型检查和类型转换

```swift
var aAnimal: Animal = Dog(species: "Huskies")
if aAnimal is Dog {
    print("\(aAnimal.species) is Dog")
}

if let dogLike = aAnimal as? Dog {
    dogLike.eat()
}
```

使用 `is` 运算符可以检查一个实例是否属于特定的类类型;
使用 `as?` 运算符可以尝试将一个实例转换为特定的子类类型。

## 多态
多态性建立在继承关系之上，是继承的一种体现。
多态性允许我们使用父类类型的引用或指针来引用子类对象，并根据实际运行时所引用的具体子类对象来调用相应的方法。
```swift
let animals: [Animal] = [Goat(species: "goat"), Dog(species: "dog"), Cat(species: "cat")]
for animal in animals {
    animal.makeSound()
}
```

通过多态性，我们可以使用父类类型的引用来处理不同类型的子类对象，并根据实际运行时所引用的具体子类对象来调用相应的方法。
这样可以使代码更灵活、可扩展，并且更符合面向对象编程的原则。
