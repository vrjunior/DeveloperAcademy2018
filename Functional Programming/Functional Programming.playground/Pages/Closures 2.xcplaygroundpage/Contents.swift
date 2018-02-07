/*:
 [Previous](@previous)
 # Closures
 */
import Foundation
/*:
 O compilador de Swift permite várias simplificações em relação a sintaxe que utilizamos na página anterior, várias delas em relação a inferência de tipos:
 */
let double:(Int)->Int = {(multiplier) -> Int in
    return multiplier * 2
}
let anotherDouble = {(multiplier:Int)->Int in
    return multiplier * 2
}
/*:
 Veja que pela inferência de tipo podemos omitir a definição ou do tipo no parâmetro, ou do tipo da constante. Outra simplificação possíveis é:
 */
let yetAnotherDouble:(Int)->Int =  {return $0 * 2}
/*:
 Como temos uma função de um parâmetro, este pode ser acessado como **$0** (assim como em funções com mais parâmetros poderiam ser acessados posicionalmente com **$1**,**$2**,**$3** etc.). No caso de *closures* com apenas uma linha de código cujo resultado é o tipo de retorno da função, a palavra **return** pode ser omitida:
 */
let yetYetAnotherDouble:(Int)->Int = { (multiplier:Int)->Int in
    multiplier * 2
}

let yetYeatAnotherDoubleWithSugarOnTop:(Int)->Int = {$0 * 2}

/*:
- Note:Cuidado para que as simplificações em escrever menos não afetem a legibilidade do seu código para os outros mortais.
 */

//: [Next](@next)
