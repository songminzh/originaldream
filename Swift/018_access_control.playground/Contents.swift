import UIKit

/// 访问控制和错误处理

/// 访问控制
/**
 open（开放访问）： 最高级别的访问权限，可以被定义的模块、模块中的任何源文件以及导入该模块的代码访问。通常用于公开公共API。

 public（公开访问）： 允许定义的模块、模块中的任何源文件以及导入该模块的代码访问。但是，与open不同，不允许其他模块继承或重写公开的类、方法和属性。

 internal（内部访问）： 默认访问级别，允许模块中的任何源文件访问。但是，不允许从模块外访问。

 fileprivate（文件私有访问）： 限制访问范围为同一文件内。只有在同一文件内的代码才能访问。

 private（私有访问）： 最低级别的访问权限，限制访问范围为同一声明内。这意味着只有在同一声明内的代码才能访问。
 
 open > public > internal > fileprivate > private
 
 规则：
 一个实体不能拥有比自身访问级别更高的类型
 扩展中可以访问原类型中所有实体，不受访问级别限制
 */
public class PublicClass {
    var internalProerty: Int = 0
    fileprivate func fileprivateMethod() {}
    private func privateMethod() {}
}

internal struct InternalStruct {
    var publicProperty: Int = 0
}

fileprivate enum FilePrivateEnum: Int {
    case A = 1
    case B = 2
    private func privateMethod() {}
}

private protocol PrivateProtocol {
    func someMethod()
}

/// 错误处理
/**
 错误处理事响应错误以及从错误中恢复的过程。
 Swift在运行时提供了抛出、捕获、传递和操作可恢复错误的支持
 */

/// 表示与抛出错误
enum VendingMachineError: Error {
    case invalidSelection // 选择无效
    case insufficientFunds(coinsNeeded: Int) // 金币不足
    case outOfStock // 缺货
}

func judgement(coins: Int, products: [String]) throws {
    if products.count == 0 {
        throw VendingMachineError.outOfStock
    }
    
    if coins <= 100 {
        throw VendingMachineError.insufficientFunds(coinsNeeded: 100 - coins)
    }
    
    print("Eligible for purchase")
}

/// 处理错误

// 使用throwing抛出异常
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = ["Candy Bar": Item(price: 12, count: 7),
                     "Chips": Item(price: 10, count: 9),
                     "Pretzels": Item(price: 7, count: 11)] // 存货清单
    var coinsDeposited = 0 // 金币剩余
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name), coins deposited: \(coinsDeposited)")
    }
}

let favoriteSnacks = ["Alice": "Chips",
                      "Bob": "Licorice",
                      "Cap": "Pretzels"]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws -> Int {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
    
    return vendingMachine.coinsDeposited
}

// 以上，使用try关键字进行执行，并在一定条件下抛出异常进行错误处理

// 使用Do-Catch处理错误
func buy(forPerson name: String, vm: VendingMachine) {
    print("buying for \(name)...")
    do {
        try buyFavoriteSnack(person: name, vendingMachine: vm)
    } catch VendingMachineError.invalidSelection {
        print("Invalid selection")
    } catch VendingMachineError.insufficientFunds(coinsNeeded: let coinsNeeded) {
        print("insufficient funds, you will also need provide \(coinsNeeded) coins")
    } catch VendingMachineError.outOfStock {
        print("Out of stock")
    } catch {
        print("Unexpected error: \(error)")
    }
    
}

let vm = VendingMachine()
vm.coinsDeposited = 15
buy(forPerson: "Alice", vm: vm)
buy(forPerson: "Bob", vm: vm)
buy(forPerson: "Cap", vm: vm)

// 将错误转换成可选值
vm.coinsDeposited = 11
if let surplusCoins = try? buyFavoriteSnack(person: "Cap", vendingMachine: vm) {
    print("Surrplus coins: \(surplusCoins)")
} else {
    print("error")
}

// 禁用错误传递 try!
// let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")

// 指定清理操作
/**
 可以使用 defer 语句在即将离开当前代码块时执行一系列语句。
 defer 语句将代码的执行延迟到当前的作用域退出之前。
 */

func processFile(filename: String) throws {
    if filename.count > 0 {
        let file = open(filename)
        defer {
            close(file)
        }
        
        while let line = try file.readLine(strippingNewline: true) {
            // 处理文件
        }
        // close(file) 会在这里被调用，即作用域的最后
    }
}

