//: [Previous](@previous)

/*:
# Extending a Core Class behavior
## Retroactive Modeling


Now let's implement a graphical diagram drawing tool based on the protocols we have already defined. The code here is just replicating the definitions we saw in the previous page.
*/



import CoreGraphics

protocol Renderer {
    
    func moveToPoint(_ point:CGPoint)
    
    func lineTo(_ point:CGPoint)
    
    func arcAt(_ center:CGPoint, radius:CGFloat, startAngle: CGFloat, endAngle: CGFloat)
    
}

protocol Drawable {
    
    func draw(_ renderer:Renderer)
    
}

struct Circle:Drawable {
    
    var center:CGPoint
    var radius:CGFloat
    
    func draw(_ renderer: Renderer) {
        renderer.arcAt(center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2.0 * Double.pi))
    }
    
}

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



let circle = Circle(center: CGPoint(x: 200.0, y: 200.0), radius: 50.0)

let square = Rectangle(position: CGPoint(x:150,y:150), size: CGSize(width: 100, height: 100))

var diagram = Diagram(elements: [circle, square])

/*:
We use CGContext to draw using Core Graphics. It keeps the current state of the drawing canvas and provides all methods to perform the drawing commands. 

So it is a very suitable class to be our renderer. And due to protocols we can use it as such!!
*/

extension CGContext : Renderer {
    
    func moveToPoint(_ point: CGPoint) {
        self.move(to:point)
    }
    
    func lineTo(_ position: CGPoint) {
        self.addLine(to:position)
    }
    func arcAt(_ center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) {
        let arc = CGMutablePath()
        addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        self.addPath(arc)
    }
}

/*:

It is important to notice that the same approach would not be possible using OOP, as we would be limited by multiple inheritance.

*/

showCoreGraphicsDiagram("Diagram") { diagram.draw($0) }


//: [Next](@next)
