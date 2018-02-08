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

// Switch statements  1.case with many cases，2. could add where，3. could add tuples, 4. could add range
// pattern matching
switch sum {
case let x where x % 2 == 0:
    print("Even")
case _ where sum == 2:
    break
default:
    print("Odd")
}
// Partial matching  underscore means ignore
let coordinates = (x: 3, y: 2, z: 5)
switch coordinates {
case (_, _, 5):
    print("我是对的")
case (let x, _, 0):
    break
default:
    break
}




