//: Playground - noun: a place where people can play

import UIKit

enum Icon: String {
    case music
    case sports
    case weather
    
    var filename: String {
        return "\(rawValue).png"
    }
}

let icon = Icon.music
icon.filename

enum WithdrawalResult {
    case success(newBalance: Int)
    case error(message: String)
}


func withdraw(amount: Int) -> WithdrawalResult {
    if amount <= 10 {
        return .success(newBalance: 1)
    } else {
        return .error(message: "Not enough")
    }
}

let result = withdraw(amount: 5)
switch result {
    case .success(let newBalance):
        print("succeed")
    case .error(let msg):
        print(msg)
}


// optionals
var age:Int?
age = 17
age = nil
switch age {
case .none:
    print("No value")
case .some(let value):
    print("Got a value:\(value)")
}

let optionalNil: Int? = .none
optionalNil == nil
optionalNil == .none



