//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


// Countable Ranges

let closedRange = 0...4
let halfOpenRange = 0..<5

// For loops
let count = 10
var sum = 0
for i in 1...count {
    sum += i
}
print(sum)

for _ in 0..<count {
    print("Hello")
}

sum = 0
for i in 1...count where i % 2 == 1 {
    sum += i
}

//重点！！ Continue and labeled statements to indicate jump to which loop
sum = 0

rowLoop: for row in 0..<8 {
    columnLoop: for column in 0..<8 {
        if row == column {
            continue
        }
        sum += row * column
    }
}

// Switch statements  case with many cases，could add where，could add tuples, could add range


