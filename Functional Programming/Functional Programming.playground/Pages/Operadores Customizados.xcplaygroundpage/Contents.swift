//: [Previous](@previous)
/*:
 # Operadores customizados
 */
import Foundation
let game = Game()

/*:
 Swift permite a criação de operadores customizados. Os operadores em swift podem ser unários (com um operando) ou binários. No caso de operadores unários estes podem ser pré-fixados (como o operador not(!)) ou pós-fixado (como o operador de optional chaninig(?)). Os operadores binários são in-fixados.
 
 Vamos criar um operador binário |==| para representar o dano (ou o modificador) de conjunto de dados. O primeiro parâmetro indica o número de dados e o segundo o número de faces.
 */
infix operator |==| : BitwiseShiftPrecedence

/*:
 Temos que definir a precedência de um operador. Como queremos que esta operação seja uma das mais altas na nossa hierarquia estou utilizando o grupo de precedência padrão mais alto (*Bitwise Shift*).
 Como um operador é uma função podemos agora implementá-lo
 */

func |==| (lhs:Int, rhs:Int) -> Modifier {
   return dices(number: lhs, sides: rhs)
}

func |==| (lhs:Int, rhs:Int) -> Damage {
    return dices(number: lhs, sides: rhs)
}

let swordDamage = apply(modifier: fixedDamage(5)/isCreature(.evil), to: fixedDamage(1))
let axeDamage = apply(modifier: 2 |==| 6 / isCreature(.earth), to: fixedDamage(10))

game.set(damage: swordDamage, for: .sword)
game.set(damage: axeDamage, for: .axe)


//: [Next](@next)
