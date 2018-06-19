//: [Previous](@previous)
//: # Generics type constraints
import Foundation

//: It is possible to define boundaries for
//: which types are appliable for a given generic type or function

protocol Unique {
    var id:Int {get}
}

//: The **table** function, for instance, just accept as
//: parameter a list of elements that conforms to protocol Unique
//: what allow us to 
func table<T:Unique> (_ list:[T]) -> [Int:T]  {
    return list.reduce([Int: T](), { (partial, element) -> [Int:T] in
        var newDictionary = partial
        newDictionary[element.id] = element
        return newDictionary
    })
}

struct Person:Unique {
    var id:Int
    var name:String
}

let personList = [Person(id: 1, name: "João"),Person(id: 3, name: "José"),Person(id: 4, name: "Maria"),Person(id: 2, name: "Antonio")]

let personDictionary =  table(personList)

personDictionary[4]?.name

//: It is possible to use more than one generic type and restrict these types

func mergeArraysUniquing<T,U:Hashable>(array1:[T], array2:[T], uniqueId:(T) -> U, uniquingValuesWith: (T,T) -> T) -> [T] {
    let totalElements = array1 + array2
    
    let elementDictionary = totalElements.reduce([U:T]()) { (partialDictionary, element) -> [U:T] in
        partialDictionary.merging([uniqueId(element) : element], uniquingKeysWith: uniquingValuesWith)
    }
    
    return elementDictionary.map { (key,value) -> T in value}
}

struct Product {
    var productId: Int
    var productName: String
    var quantity:Int
}

let shoppingList1 = [
    Product(productId: 1, productName: "arroz", quantity: 1),
    Product(productId: 3, productName: "leite", quantity: 2),
    Product(productId: 5, productName: "feijão", quantity: 1),
    Product(productId: 8, productName: "chocolate", quantity: 3)]

let shoppingList2 = [
    Product(productId: 8, productName: "chocolate", quantity: 2),
    Product(productId: 6, productName: "vinho", quantity: 1),
    Product(productId: 9, productName: "macarrão instantâneo", quantity: 3),
    Product(productId: 3, productName: "leite", quantity: 2)]


let finalList = mergeArraysUniquing(array1: shoppingList1, array2: shoppingList2, uniqueId: {$0.productId}) { (product1, product2) -> Product in
    Product(productId: product1.productId, productName: product1.productName, quantity: product1.quantity + product2.quantity)
}

print(finalList)

//: [Next](@next)
