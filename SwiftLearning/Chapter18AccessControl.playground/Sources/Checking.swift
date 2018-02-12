import Foundation

public class CheckingAccount: BasicAccount {
    private let accountNumber = UUID().uuidString
    
    class Check {
        let account: String
        var amount: Dollars
        private(set) var cashed = false
        
        func cash() {
            cashed = true
        }
        // 避免随意创建 Check 类
        fileprivate init(amount: Dollars, from account: CheckingAccount) {
            self.amount = amount
            self.account = account.accountNumber
        }
    }
    
    func writeCheck(amount: Dollars) -> Check? {
        guard balance > amount else {
            return nil
        }
        let check = Check(amount: amount, from: self)
        withdraw(amount: check.amount)
        return check
    }
    func deposit(_ check: Check) {
        guard !check.cashed else {
            return
        }
        deposit(amount: check.amount)
        check.cash()
    }
}
