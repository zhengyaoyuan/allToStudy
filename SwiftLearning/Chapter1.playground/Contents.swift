//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
// Large number could be divided by underscore, as many as you like
var largeNum = 1_000_999_989

var integer = 100
var decimal = 90.0
// Convert the type like this!!
integer = Int(decimal)
// Operators with mixed types
let hourlyRate = 19.5
let hoursWorked = 10
let totalCost = hourlyRate * Double(hoursWorked)

// type inference key feature
let typeInferredInt = 42
let typeInferredDouble = 3.14159
let actuallyDouble = 3 as Double

// Strings
let characterDog = "a"
var message = "Hello" + ", my boy"
// Concatenation
let exclamationMark: Character = "!"
message += String(exclamationMark)
// Interpolation
let oneThird = 1.0 / 3.0
let oneThirdLongString = "One third is \(oneThird) as a decimal"
// Multi-line strings
let bigString = """
    You can have a string
    that
    line.
    """
print(bigString)

// Tuples
let coordinates = (2.1, 3)
let x1 = coordinates.0
let coordinatesNamed = (x: 2, y: 3)
let x2 = coordinatesNamed.x
let (x3, y3) = coordinatesNamed
// underscore means ignore
let (x4, _) = coordinatesNamed

// A whole lot of number types

// A peek behind the curtains: Protocols




















