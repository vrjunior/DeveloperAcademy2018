//: [Previous](@previous)
//: # List Equality
//: This playground explains how the list equality works using high-level functions zip
//: and contains

import UIKit

let heManCharacters = ["Gorpo","He-Man","Teela","Mentor"]
let heManCharactersAgain = ["Gorpo","He-Man","Teela","Mentor"]
let lotrCharacters = ["Frodo","Bilbo","Legolas","Faramir"]


//:Zip will put the 2 list elements together as a tuple. The flat map is
//: generating a String list so we can see these pairs.

var zippedList = zip(heManCharacters, heManCharactersAgain)
let list = zippedList.flatMap({return "\($0)|\($1)"})
list

//: Contains ask a function that receives an element and return true if
//: it satisfies a condition. It is iteated for each element until it returns true
let isTeelaHere = zippedList.contains(where: {print("\($0)|\($1)"); return $0 == "Teela" })
isTeelaHere

//: We use it to check if all pairs are equal. The command bellow check if
//: the list contains an element where the two tuple items are identical.
//: It will find the first element (Gorpo, Gorpo)
print("============================")
zippedList.contains(where: {print("\($0)|\($1)"); return $0 == $1 })


//: But we want to check if the zipped list contain at least one element where
//: the tuple items are diferent.
print("============================")
let result = zippedList.contains(where: {print("\($0)|\($1)"); return !($0 == $1) })
result

//: If the zipped list does not contain any element that is different, it means
//: the lists are equal 😜
let listsAreEqual = !result






//: [Next](@next)
