//: [Previous](@previous)

//:# Protocol Oriented Example
//: Now we are going to implement a classic example of inheritance and polimorphism using
//: protocol oriented programming. 

//:We will implement a diagram drawing tool, that has several
//: drawable items mapped into a diagram and a renderer mechanism to draw it.
//:
//: ![Blah](Diagram.png)

import CoreGraphics

/*: 
 The first thing to do is implement the top level abstractions. If we were thiking on OOP it would be the high level classes Renderer and Drawable.

 Shifiting to a protocol oriented paradigm we start defining protocols.
*/

protocol Renderer {
    
    func moveToPoint(_ point:CGPoint)
    
    func lineTo(_ point:CGPoint)
    
    func arcAt(_ center:CGPoint, radius:CGFloat, startAngle: CGFloat, endAngle: CGFloat)
    
}

//A drawable knows how to draw itself using the renderer available commands.
protocol Drawable {
    
    func draw(_ renderer:Renderer)
    
}

/*:
 Let's start implementing the circle as a struct (value type). We will try to avoid using reference types when they are not needed.
*/

struct Circle:Drawable {
    
    var center:CGPoint
    var radius:CGFloat
    
    func draw(_ renderer: Renderer) {
        renderer.arcAt(center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2.0 * M_PI))
    }
    
}

/*:
 Let's also implement a "*debug renderer*" that prints on the console all
graphic commands.
*/

struct TextRenderer: Renderer {
    
    func moveToPoint(_ point:CGPoint) {
        print("moveToPoint\(point)")
    }
    
    func lineTo(_ point:CGPoint) {
         print("lineTo\(point)")
    }
    
    func arcAt(_ center:CGPoint, radius:CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
         print("arcAt(\(center), radius:\(radius), startAngle: \(startAngle), endAngle: \(endAngle))")
    }
    
}

//: We can now create a circle and "draw" it...
let circle = Circle(center: CGPoint(x: 200.0, y: 200.0), radius: 50.0)


circle.draw(TextRenderer())


/*:
Now we are going create a new item (square) and a diagram to hold a set of items.
*/

struct Rectangle:Drawable {
    
    var position:CGPoint
    var size:CGSize
    
    func draw(_ renderer: Renderer) {
        renderer.moveToPoint(position)
        renderer.lineTo(CGPoint(x: position.x + size.width, y: position.y))
        renderer.lineTo(CGPoint(x: position.x + size.width, y: position.y + size.height))
        renderer.lineTo(CGPoint(x: position.x, y: position.y + size.height))
        renderer.lineTo(position)
    }
    
}

struct Diagram:Drawable {
    
    var elements:[Drawable]
    
    func draw(_ renderer: Renderer) {
        for element in elements {
            element.draw(renderer)
        }
    }
}


/*:
... and add a brand new square to it
*/

let square = Rectangle(position: CGPoint(x:150,y:150), size: CGSize(width: 100, height: 100))


var diagram = Diagram(elements: [circle, square])


print("=======================================")

diagram.draw(TextRenderer())


/*:
Finally, let's add the diagram we have now as a sub-diagram of itself
*/

diagram.elements.append(diagram)
print("=======================================")
diagram.draw(TextRenderer())


/*:
If we have tried the same thing with classes we would have an infinite loop as the diagram draw method it call itself over and over again.

Using value types it dows not happen: the diagram that was added is just a copy of the original diagram on that moment. That can be usefull, but also leads to errors.


It is important to remind this differences to choose when use a reference or a value type.
*/

//: [Next](@next)




