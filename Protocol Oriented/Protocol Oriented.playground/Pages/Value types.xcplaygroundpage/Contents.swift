//: # Value types x Reference types

import Foundation

//: The basic reference type on Swift is the class. When you assign an object 
//: its reference (memory address) is kept. Therefore, if you assign another
//: variable to the same object you have two references to the same object stored.

class CounterClass {
    var counter:Int = 0

}

//: Let's check how two references share information and can change the same object...
let aCounter = CounterClass()
let assignedCounter = aCounter

aCounter.counter += 1

aCounter.counter
assignedCounter.counter

assignedCounter.counter += 1

aCounter.counter
assignedCounter.counter

//: These reference-oriented leads to implicit sharing, with the same piece of data being
//: used by several references. It can generate issues as colateral effects and race conditions.
//: Structs, on the other hand, are passed by value, being copied whenever assigned.

//Let's check how the same scenario above is handled with structs.

struct CounterStruct {
    var counter:Int = 0
    
}

//: With value types if we declare them as constants, they can not be changed. If the next two lines
//: are uncommented we will get an error.


//let aValueCounter = CounterStruct()
//aValueCounter.counter += 1

var aValueCounter = CounterStruct()
var aValueCounterCopy = aValueCounter

aValueCounter.counter += 1

aValueCounter.counter
aValueCounterCopy.counter

aValueCounterCopy.counter += 1

aValueCounter.counter
aValueCounterCopy.counter


//: Recursive data types (a type that refers to itself) are not supported for value types. It makes sense, as we are always copying
//; a "snapshot" and not referencing an element itself. If the next lines are uncommented, we will get an error.

/*
struct LinkedListNode {
    
    var value: String!
    var next: LinkedListNode?
    
}
*/

//: Structs supports functions in a very simmilar way as classes. A difference is that a struct's function that changes its values must be marked as mutating. Otherwise it will have read-only access to "self".
//: You can comment the mutating modifier to check the error.

struct Accumulator {
    var counter:Int = 0
    
    mutating func increment() {
        counter += 1
    }
}

//: Besides structs we also have enums as value types. Those are very powerfull in swift: they can store raw values, store associated values, have computed properties and functions.
//: Last but not least we have tuples, that are sequential structures that are also value types.




//: [Next](@next)



