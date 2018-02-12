import Foundation

protocol Account {
    associatedtype Currency
    
    var balance: Currency { get }
    func deposit(amount: Currency)
    func withdraw(amount: Currency)
}

typealias Dollars = Double

public class BasicAccount: Account {
    // private
    private(set) var balance: Dollars = 0.0
    
    public func deposit(amount: Double) {
        balance += amount
    }
    
    public func withdraw(amount: Double) {
        if amount <= balance {
            balance -= amount
        } else {
            balance = 0
        }
    }
}

//let account = BasicAccount()
//account.deposit(amount: 10.0)
//account.withdraw(amount: 5.0)
// 可以随意修改！！，不好啊。。 尽管协议规定 balance 是只读的，但实现类让这个属性也可写了。
//account.balance = 1000.0


