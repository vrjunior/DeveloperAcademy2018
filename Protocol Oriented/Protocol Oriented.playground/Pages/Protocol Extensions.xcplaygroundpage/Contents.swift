//: [Previous](@previous)


//: # Protocol Extensions
//: Extensions allow adding new functionalities to existing types.
//:
//: We are going to use it to create customization points on a protocol.


//: Let's start with a basic protocol
protocol BaseProtocol {
    
    func a() -> String
    
}

//: Now we will add two function implementations: one defined on the protocol
extension BaseProtocol {
    func a() -> String {
        return "Base - A"
    }
    
    func b() -> String {
        return "Base - B"
    }
}

//: Let's create another protocol that inherits from our base protocol
protocol InheritedProtocol: BaseProtocol {}


//: And implement both methods as we did before.
extension InheritedProtocol {
    func a() -> String {
        return "Child - A"
    }
    
    func b() -> String {
        return "Child - B"
    }
}

//: Finally, let's create structs that cope with these protocols...
struct BaseImplementation: BaseProtocol {}
struct InheritedImplementation: InheritedProtocol {}

//: and see how these methods are called.
var element: BaseProtocol = BaseImplementation()
element.a()
element.b()

var inheritedElement:InheritedProtocol = InheritedImplementation()
inheritedElement.a()
inheritedElement.b()

element = InheritedImplementation()
element.a()
element.b()

//: When using the base protocol, all methods defined within it are customization points
//: that are overriden by the inherited types. The methods defined just on extensions shadows
//: any further implementation ( InheritedProtocol.b() is a method from InheritedProtocol, not
//: a new implementation of BaseProtocol.b())

//: [Next](@next)
