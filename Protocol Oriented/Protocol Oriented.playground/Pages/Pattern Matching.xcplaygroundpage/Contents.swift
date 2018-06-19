//: [Previous](@previous)
//: # Pattern matching
//: An useful and powerful feature of Swift is pattern matching.
//: It enables simpler statements for type and value checking, that would be
//: much more verbose otherwise

import Foundation

//: One example of a pattern matching is the type comparison and casting
//: using as?, as! and is
//: We could use is to check if a variable or constant matches a given type:
"This is a String!" is String
"But this is not an integer, for sure..." is Int

let a:Any = 3

switch (a) {
case is Int: print(a)
default: print("Sei lá")
}

//: Its is important to notice that is do not cast the value, just checks
//: the type. The following code, if uncommented, will generate an error, as
//: a still being of **Any** type.
/*
 switch (a) {
 case is Int: print(a+1)
 default: print("Sei lá")
 }
 */

//: Pattern matching also allows us to work with associated values
//: on enumerations:

enum GeometricShapes {
    case circle (center:(Int,Int),radius:Int)
    case rectangle ((Int,Int), (Int,Int))
    case polygon([(Int,Int)])
}

//: Switch- Case in Swift is a very felxible command as it allow cases based
//: on pattern matching. We can ,for instance, extract the associated values
//: of a enum case using the case-let command:

func description(shape:GeometricShapes) {
    switch (shape) {
    case .circle(center:(let x, let y), radius: let radius):
        print ("Circle: Center(\(x),\(y)), Radius: \(radius)")
    case .rectangle((let x, let y), (let width, let height)):
        print ("Rectangle: Center(\(x),\(y)), Size: \(width) x \(height)")
    case .polygon(let points):
        let list = points.reduce("") { (string, point) -> String in
            return "\(string)(\(point.0),\(point.1)) "
        }
        print ("Polygon: \(list)")
    }
}

description(shape: .circle(center:(3, 2),radius: 5))
description(shape: .rectangle((2, 2), (6, 1)))
description(shape: .polygon([(1,1), (2,2), (3,1)]))


//: The same pattern matching could be used on an if statement:
let shape = GeometricShapes.circle(center: (10, 3), radius: 5)

if case .circle(center:let (centerX, centerY), radius: _ ) = shape {
    print("It is a circle centered on (\(centerX), \(centerY))!")
}

//: - Note: The _ wildcard indicates to match any value and ignore it.

//: The for-where statement allows validating a condition to
//: iterate just through a subset of items:
for element in 1...10 where element % 2 == 0 {
    print("\(element) is even")
}

let shapeList:[GeometricShapes] = [.circle(center:(3,2), radius: 4), .rectangle((10, 10), (3, 2)), .circle(center: (8, 1), radius: 1), .rectangle((10, 10), (3, 3))]

//: We can use a for-case statement to iterate through a enum list of an specific case
//: extracting relevant information from it
for case let .circle((centerX, centerY), radius) in shapeList {
    print("I found a circle centered on (\(centerX),\(centerY)) and radius = \(radius)!")
}

//: And it could also be used with an dwhere clause
for case let .rectangle(_, size) in shapeList where size.0 == size.1 {
    print ("I found a square!!!")
}

for case let .rectangle(_, (width, height)) in shapeList where width == height {
    print ("I found a square!!!")
}

//: [Next](@next)
