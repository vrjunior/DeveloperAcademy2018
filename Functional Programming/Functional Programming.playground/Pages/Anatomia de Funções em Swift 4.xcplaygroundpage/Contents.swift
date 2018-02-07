//: [Previous](@previous)
/*:
 # Anatomia de Funções em Swift
 */
import Foundation
/*:
 Uma função em Swift pode também retornar uma outra função:
 */
func createDoubleFunction() -> (Int)->Int {
    return { (multiplier)->Int in
        return multiplier * 2
    }
}
/*:
 Criamos aqui uma função sem parâmetros que retorna uma função que tem como parâmetro um inteiro e retorna um inteiro (ou seja uma função de tipo (Int)->Int). Nossa função **createDoubleFunction**, neste caso, é portanto do tipo ( )->(Int)->Int. Prefiro, em termos de legibilidade ( )->((Int)->Int), embora a outra forma faça mais sentido em alguns contextos...
 */
let double = createDoubleFunction()
/*:
 A constante **double** recebeu o resultado da execução de **createDoubleFunction** que no caso é uma função e pode ser utilizada de acordo com sua estrutura:
 */


double(3)

/*:
 Funções que recebem funções como parâmetro ou que as retornam como resultado são chamadas de funções de alta ordem.
 */



//: [Next](@next)
