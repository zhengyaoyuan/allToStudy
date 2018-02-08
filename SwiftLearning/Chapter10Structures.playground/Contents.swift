//: Playground - noun: a place where people can play

import UIKit

struct Location {
    let x: Int
    let y: Int
}

struct DeliveryArea: CustomStringConvertible {
    let center: Location
    var radius: Double
    
    func contains(_ location: Location) -> Bool {
        let distanceFromCenter = distance(from: (x: center.x, y: center.y), to: (x: location.x, y: location.y))

        return distanceFromCenter < radius
    }
    
    var description: String {
        return """
            这是我的地方
            你好吗
            """
    }
    
}

let storeLocation = Location(x: 2, y: 4)
var storeArea = DeliveryArea(center: storeLocation, radius: 4)

let areas = [
    DeliveryArea(center: Location(x: 2, y: 4), radius: 2.5),
    DeliveryArea(center: Location(x: 9, y: 7), radius: 4.5)
]

func distance(from source: (x: Int, y: Int), to target: (x: Int, y: Int))
    -> Double {
        let distanceX = Double(source.x - target.x)
        let distanceY = Double(source.y - target.y)
        return (distanceX * distanceX + distanceY * distanceY).squareRoot()
}

func isInDeliveryRange(_ location: Location) ->Bool {
    for area in areas {
        let distanceToStore = distance(from: (x: area.center.x, y: area.center.y), to: (x: location.x, y: location.y))
        if distanceToStore < area.radius {
            return true
        }
    }
    return false
}

let customerLocation1 = Location(x: 8, y: 1)
let customerLocation2 = Location(x: 5, y: 5)
print(isInDeliveryRange(customerLocation1))
print(isInDeliveryRange(customerLocation2))

let area = DeliveryArea(center: Location(x: 5, y: 5), radius: 4.5)
let customerLocation = Location(x: 2, y: 2)
area.contains(customerLocation)

print(area)

