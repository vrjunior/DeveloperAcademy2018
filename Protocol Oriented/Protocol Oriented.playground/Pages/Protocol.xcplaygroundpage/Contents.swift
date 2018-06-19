//: [Previous](@previous)

//: # Protocols
//: Protocols are the backbone of protocol oriented programming. They have simmilar
//: responsabilities as classes in object oriented programming.
//:
//: Protocols basically define a contract that shall be respected by any
//: type that implements them.

protocol Accumulator {
    
    var value:Int {get set}
    
    //This function is marked as mutating to be used
    //both on value and reference types.
    mutating func increment()
    
}


//: One powerfull resource is protocol extensions. It 
//: allows the definition of a default implementation of a function. A type
//: that implements this protocols receieves that implementation for free.

extension Accumulator {
    
    mutating func increment() {
        value += 1
    }
    
}

class Counter:Accumulator {
    var value:Int = 0
}


//If counter is marked as immutable (let) we will receive an error due to the
//mutating modifier on the protocol
var counter = Counter()
counter.increment()
counter.value


//: Protocols can be extended through inheritance.

protocol ResetableAccumulator : Accumulator {
    mutating func reset()
}

//: Also protocols can be composed, allowing types to adopt multiple protocols. 
//: This resource allows decoupling functionalities into smaller sets giving much more
//: flexibility than class inheritance.

protocol Painter {
    func paint()
}

protocol Inventor {
    func createStuff()
}

protocol Sculptor {
    func sculpt()
}

protocol DaVinci: Painter, Inventor, Sculptor {
    
}

protocol Michelangelo: Painter, Sculptor {
    
}

//: [Next](@next)














