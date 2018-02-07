/*:
 [Previous](@previous)
 # Closures
 */
import Foundation
/*:
 Em termos de definições, funções *lambda* são função anônimas, que podem ser definidas *inline* no código, enquanto *closures* são função (anônimas ou não) que englobam o contexto onde são definidas, podendo acessar dados que não estão em seus parâmetros.
 
 Em Swift, a definição dada para *closure* é de um bloco auto-contido de código que pode ser passado e utilizado no resto de seu código. Uma closure em Swift mistura ambos os conceitos.
*/
let double:(Int)->Int = { (multiplier:Int) -> Int in
    return multiplier * 2
}
double(2)
/*:
 Criamos aqui uma closure, definida pelo código entre chaves. Esta recebe um parâmetro inteiro chamado multiplier (internamente apenas, pois nomes externos são sempre omitidos em closures) e retornamos um inteiro, como podemos ver na primeira linha deste código. O corpo da função é definido por tudo que segue a palavra reservada *in* até o fim da closure.
*/
//: [Next](@next)
