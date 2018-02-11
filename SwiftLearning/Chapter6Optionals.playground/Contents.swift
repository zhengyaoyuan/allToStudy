//: Playground - noun: a place where people can play

import UIKit

var authorName: String? = "Harrold"
if authorName != nil {
    print("有名字 \(authorName!)")
} else {
    print("没名字")
}

if let authorName = authorName {
    print("有名字 \(authorName)")
}

func calculateNumberOfSides(shape: String) -> Int? {
    switch shape {
    case "Triangle":
        return 3
    case "Square":
        return 4
    case "Rectangle":
        return 4
    case "Pentagon":
        return 5
    case "Hexagon":
        return 6
    default:
        return nil
    } }

func maybePrintsSides(shape: String) {
    guard let sides = calculateNumberOfSides(shape: shape) else {
        print("I dont know the number")
        return
    }
    
    print("I have number")
}

maybePrintsSides(shape: "TTT")

