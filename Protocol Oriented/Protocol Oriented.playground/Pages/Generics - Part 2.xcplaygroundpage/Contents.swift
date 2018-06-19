//: [Previous](@previous)
//: # Generics
import Foundation

//: Similarly to functions, classes and structs also can be generalized
//: for its methods or attributes

class Node<T> {
    var value:T
    var left:Node<T>?
    var right:Node<T>?
    
    init(value:T) {
        self.value = value
    }
    
    func visit() {
        print("\(value)")
    }
    
    func inorder() {
        left?.visit()
        visit()
        right?.visit()
    }
}

let rootNode = Node(value: "a")
var node = Node(value: "b")
rootNode.left = node
node = Node(value: "c")
rootNode.right = node
 
rootNode.inorder()


//: [Next](@next)
