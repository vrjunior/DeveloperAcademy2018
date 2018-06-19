//: [Previous](@previous)

//: # Equality
//:
//: Value-types are equivalent when they hold the same value,no matter how you
//: reach this value.
//:
//: In order to guarantee this, whenever you implement a value-type it is highly 
//: recommended that you implement the *Equatable* protocol.
//:
//: *Equatable* override the == operator and must respect three rules:
//: * Reflexive - x == x is true
//: * Symmetric - x == y then y == x
//: * Transitive - x == y and y == z then x == z


//: Here we have just the basic implementation of the diagram and renderer protocols and structures

import CoreGraphics

protocol Renderer {
    
    func moveToPoint(_ point:CGPoint)
    
    func lineTo(_ point:CGPoint)
    
    func arcAt(_ center:CGPoint, radius:CGFloat, startAngle: CGFloat, endAngle: CGFloat)
    
}

struct Circle:Drawable {
    
    var center:CGPoint
    var radius:CGFloat
    
    func draw(renderer: Renderer) {
        renderer.arcAt(center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2.0 * Double.pi))
    }
    
}

struct Rectangle:Drawable {
    
    var position:CGPoint
    var size:CGSize
    
    func draw(renderer: Renderer) {
        renderer.moveToPoint(position)
        renderer.lineTo(CGPoint(x: position.x + size.width, y: position.y))
        renderer.lineTo(CGPoint(x: position.x + size.width, y: position.y + size.height))
        renderer.lineTo(CGPoint(x: position.x, y: position.y + size.height))
        renderer.lineTo(position)
    }
    
}

struct Diagram:Drawable {
    
    var elements:[Drawable]
    
    func draw(renderer: Renderer) {
        for element in elements {
            element.draw(renderer: renderer)
        }
    }
}


//: The basic comparison for diagram items can be done directly comparing its attributes.
extension Circle: Equatable {}
extension Rectangle: Equatable {}

func == (lhs:Circle, rhs:Circle) -> Bool {
    return lhs.center == rhs.center && lhs.radius == rhs.radius
}

func == (lhs:Rectangle, rhs:Rectangle) -> Bool {
    return lhs.position == rhs.position && lhs.size == rhs.size
}



//: To make diagram equatable we should be able to compare its elements. As we have heterogeneous
//: items within it we should be able to compare any drawable with another. We should make Drawable
//: Equatable, but it has Self requirements (func == (Self, Self) -> Bool). Our diagram can not be 
//: limited by this homogeneous comparison.
//:
//: If we implement *isEqualTo*(other: Drawable) we generate a Self requirement on Drawable and then we
//: need to make all possible Drawable combinations == functions!


protocol Drawable {
    
    func draw(renderer:Renderer)
    func isEqualTo(_ other: Drawable) -> Bool
}


//: As we know that two distinct types of drawable are inherently distinct we can make an extension for
//: Equatable to handle Drawables comparison when types do not match (using the == implementation when 
//: they do).


extension Equatable where Self : Drawable {
    func isEqualTo(_ other: Drawable) -> Bool {
        if let o = other as? Self {
             //Equatable == Self requirements are satisfied! Homogeneous comparison!
             return self == o
        } else {
            return false
        }
       
    }
}

//: Then we can implement Diagram equality using it. We check all
//: elements on the same index and if all are equal, the whole list is also equal.
//:
//: Details about that can be seen on [Appendix A](Appendix%20A)
extension Diagram : Equatable {}
func == (lhs: Diagram, rhs: Diagram) -> Bool {
    return lhs.elements.count == rhs.elements.count
        && !zip(lhs.elements, rhs.elements).contains { !($0.0).isEqualTo($0.1) }
}

let circle = Circle(center: CGPoint(x: 200.0, y: 200.0), radius: 50.0)
let square = Rectangle(position: CGPoint(x:150,y:150), size: CGSize(width: 100, height: 100))
let diagram = Diagram(elements: [circle, square])
let diagram2 = Diagram(elements: [circle, square])
let diagram3 = Diagram(elements: [square, square])

diagram == diagram2
diagram == diagram3


//: [Next](@next)
