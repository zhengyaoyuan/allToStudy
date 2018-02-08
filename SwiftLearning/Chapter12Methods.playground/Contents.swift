//: Playground - noun: a place where people can play

import UIKit

let months = ["January", "February", "March",
              "April", "May", "June",
              "July", "August", "September",
              "October", "November", "December"]

struct SimpleDate {
    var month: String
    
    init() {
        month = "January"
    }
    
    func monthUntilWinterBreak(from date: SimpleDate) -> Int {
        return months.index(of: "December")! - months.index(of: date.month)!
    }
}

let date = SimpleDate()

struct Math {
    var names: Int
    
}

extension Math {
    static func printdd() -> Void {
        print("I love you")
    }
    
    init() {
        names = 3
    }
}

Math.printdd()
let math = Math()
let math1 = Math(names: 4)


