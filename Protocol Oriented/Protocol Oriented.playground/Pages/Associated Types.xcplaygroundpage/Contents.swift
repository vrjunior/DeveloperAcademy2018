//: [Previous](@previous)

//: # Associated Types and Generics
//: Using protocols we can define a generic implementation of an algorithm an associate it with
//: a given type. Lets make a stack using this idea

import Foundation

protocol StackProtocol {
    associatedtype ElementType
    
    mutating func push(_ item:ElementType)
    
    mutating func pop()->ElementType?
}


//: This implementation uses String as ElementType, what could 
//: be inferred by the function implemented

struct NameStack:StackProtocol {
    
    var stack = [String]()
    
    
    mutating func push(_ item: String) {
        stack.insert(item, at: 0)
    }
    
    mutating func pop()->String? {
        if (stack.count > 0) {
            
            let element = stack[0]
            stack.removeFirst()
            return element
            
        } else {
            
            return nil
            
        }
    }
}


var stack = NameStack()

stack.push("João")
stack.push("Maria")
stack.push("José")

stack.pop()
stack.pop()
stack.pop()
stack.pop()


//: It is also possible to implement it using Generics

struct Stack<T>:StackProtocol {
    
    
    var stack = [T]()
    
    
    mutating func push(_ item: T) {
        stack.insert(item, at: 0)
    }
    
    mutating func pop()->T? {
        if (stack.count > 0) {
            
            let element = stack[0]
            stack.removeFirst()
            return element
            
        } else {
            
            return nil
            
        }
    }
    
}

var genericNameStack = Stack<String>()

genericNameStack.push("João")
genericNameStack.push("Maria")
genericNameStack.push("José")

genericNameStack.pop()
genericNameStack.pop()
genericNameStack.pop()
genericNameStack.pop()

//: [Next](@next)
