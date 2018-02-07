//: [Previous](@previous)
/*:
 # Sistema de Danos de RPG
 */
import Foundation
/*:
 Para introduzir alguns conceitos de programação funcional vamos utilizar como exemplo um sistema de dano para RPG. Como estes sistemas apresentam regras para situações específicas além de modificadores (que ocorrem, por exemplo quando a arma é alvo de algum encantamento).
 Desta forma, para implementar tal sistema é interssante que consigamos compor a regra de dado de uma arma a partir de regras  simples, que possam ser unidas. Existem padrões que podem ser utilizados para resolver este problema de forma orientada a objetos, porém como estamos decompondo apenas uma regra e não um conjunto de dados, a abordagem funcional parece mais aderente ao problema.
 */
/*:
 Vamos inicialmente criar os tipos de dados que serão importantes para a resolução do problema. O sistema de danos que iremos utilizar vai se basear em três elementos: o personagem, o inimigo e a distância entre eles:
 */
struct RPGCharacter {
    var name:String
    //Aributos
    var strength:Int
    var dextery:Int
}

enum CreatureType {
    case earth, air, water, fire
}

enum Alignment {
    case good, neutral, evil
}

struct Enemy {
    var name:String
    var alignment:Alignment
    var type:CreatureType
}
/*:
 A regra de dano é função, como já dito, do personagem, do inimigo e da distância entre eles. As funções de dano, numa abordagem funcional são também tipos, logo vamos definir o tipo que define regras de dano:
 */

typealias Damage = (RPGCharacter, Int, Enemy) -> Int


//: [Next](@next)
