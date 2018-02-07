//: [Previous](@previous)
/*:
 # Anatomia de Funções em Swift
 */
import Foundation
/*:
 Uma função em Swift pode ser passada como parâmetro para outra função, permitindo alterar a lógica desta última:
 */
func executeOperation(operation:(Int,Int)->Int,on number1:Int, and number2:Int)->Int {
    //Aqui poderia fazer outras coisas...
    let result = operation(number1,number2)
    //Aqui também...
    return result
}

executeOperation(
    operation: { (a, b) -> Int in
        2 * a + b
},
    on: 3, and: 1)

/*:
 Um ponto interessante para lembrar neste momento é que operadores em Swift são funções também...
 */
executeOperation(operation: *, on: 3, and: 2)

/*:
 Este mecanismo é amplamente utilizado em Swift para: definir o estado final de uma animação, para tratar retorno de chamadas assíncronas e para uso de algumas funções de manipulação de coleções.
*/

//: [Next](@next)
