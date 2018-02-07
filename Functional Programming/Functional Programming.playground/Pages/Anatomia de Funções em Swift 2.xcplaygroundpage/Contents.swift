/*:
 [Previous](@previous)
 # Anatomia de Funções em Swift
 */
import Foundation
/*:
 Como dito, uma função é uma cidadã de primeira classe, podendo ser utilizada da mesma forma como tipos de dado em Swift. Desta forma podemos atribuir uma função a uma variável ou constante e utilizá-la posteriormente.
 */
func multiplyBy2 (multiplier number:Int) -> Int {
    return number * 2
}

var double:(Int)->(Int) = multiplyBy2

double(2)
/*:
 A variável ou constante que guarda a função é, também, uma função (assim como uma variável que guarda uma String é uma String), podendo ser utilizada como tal.
 O tipo pode ser omitido no caso de poder ser inferido pelo compilador:
 */
let anotherDouble = multiplyBy2

anotherDouble(3)

//: [Next](@next)
