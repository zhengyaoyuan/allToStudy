//: Playground - noun: a place where people can play

import UIKit

var multiplyClosure: (Int, Int) -> Int

multiplyClosure = { (a: Int, b: Int) -> Int in
    return a * b
}

let result = multiplyClosure(4, 2)


multiplyClosure = { (a: Int, b: Int) -> Int in
    a * b
}

// 从变量那里，获取到了类型消息
multiplyClosure =  { (a, b) in
    a * b
}

multiplyClosure = {
    $0 * $1
}

func operateOnNumbers(_ a: Int, _ b: Int,
                      operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    print(result)
    return result
}

operateOnNumbers(4, 2, operation: { (a: Int, b: Int) -> Int in
    return a + b })

// trailing closure syntax
operateOnNumbers(4, 2) {
    $0 + $1
}

let voidClosure: () -> Void = {
    print("Swift is good")
}
voidClosure()

let names = ["ZZA", "AA", "BBCCC"]
names.sorted {
    $0.count > $1.count
}

var prices = [1.5, 10, 20, 100]
let largePrices = prices.filter {
    $0 > 9
}

let sum = prices.reduce(0) {
    return $0 + $1
}

let price1 = prices.dropLast()
let price2 = prices.dropLast(2)

let firstTwo = prices.prefix(2)

let myStr = "jjfjf"
//let oneC = myStr[0]
let firstIndex = myStr.startIndex
let firstChar = myStr[firstIndex]

let fullName = "Matt Galloway"
let spaceIndex = fullName.index(of: " ")!
var firstName = fullName[fullName.startIndex..<spaceIndex]
firstName = fullName[..<spaceIndex]









