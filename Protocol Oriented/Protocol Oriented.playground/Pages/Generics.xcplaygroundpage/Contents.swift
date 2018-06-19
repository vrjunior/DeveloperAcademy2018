//: [Previous](@previous)
//: # Generics
//: Generics is a language feature that allows creating generic code,
//: what means, pieces of code that can be applied to all or to a specific set if types
import Foundation

//: Let's suppose we have a function to swap integers

func swapInt(_ a: inout Int,_ b :inout Int) {
    let temporary = a
    
    a = b
    b = temporary
}

var a = 3, b = 5

print("\(a) x \(b)")

swapInt(&a,&b)

print("\(a) x \(b)")

//:We would need a different methods, very similar to handle other types

func swapString(_ a: inout String, _ b :inout String) {
    let temporary = a
    
    a = b
    b = temporary
}


var c = "String1", d = "String2"

print("\(c) x \(d)")

swapString(&c,&d)

print("\(c) x \(d)")


//:It would be hard to develop and mantain code for every type that
//: we could swap values. Considering that the code is pratically the same
//: (but the parameter types), a generic function for this could solve the problem:

func swapMethod<T>(_ a :inout T, _ b:inout T) {
    let temporary = a
    
    a = b
    b = temporary
}

//: The <T> clause indicates that this function shoudl work with a type T, whatever it is
//: since both parameters preserve this same type.

swapMethod(&a, &b)
swapMethod(&c, &d)

print("\(a) x \(b)")
print("\(c) x \(d)")

//: With this solution we have just one piece of code that can handle any type...

var e = 3.5, f = 4.1
swapMethod(&e, &f)
print("\(e) x \(f)")


//: [Next](@next)
