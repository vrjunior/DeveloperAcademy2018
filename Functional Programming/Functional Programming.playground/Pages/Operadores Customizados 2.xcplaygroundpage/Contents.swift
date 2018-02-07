//: [Previous](@previous)
/*:
 # Operadores customizados
 */
import Foundation
let game = Game()
/*:
 Vamos criar agora um operador ~> para representar a aplicação de um modificador em um dano base. Para este operador vamos criar um grupo de precedência customizado.
 */

precedencegroup ModifierApplicationGroup {
    lowerThan:AssignmentPrecedence
    associativity:right
}

infix operator ~> : ModifierApplicationGroup

func ~> (lhs:Modifier, rhs:@escaping Damage) -> Damage {
    return apply(modifier: lhs, to: rhs)
}


let swordDamage = fixedDamage(10) / isCreature(.evil) ~> fixedDamage(1) ~> 1 |==| 6
let axeDamage = 2 |==| 6 / isCreature(.earth) ~> fixedDamage(10)

game.set(damage: swordDamage, for: .sword)
game.set(damage: axeDamage, for: .axe)

/*:
 Podemos criar o operador <~ para representar a aplicação do modificador à direita no dano da esquerda (que facilitará a leitura).
 */

infix operator <~ : ModifierApplicationGroup

func <~ (lhs:@escaping Damage, rhs:Modifier) -> Damage {
    return apply(modifier: rhs, to: lhs)
}

let daggerDamage = fixedDamage(1)  <~ fixedDamage(1) / isCreature(.evil)
let saberDamage = (fixedDamage(10) <~ 2 |==| 6 / isCreature(.earth)) <~ fixedDamage(1) / isCreature(.evil)

game.set(damage: daggerDamage, for: .dagger)
game.set(damage: saberDamage, for: .saber)

/*:
 Veja que o operador precisou de parênteses no caso de múltiplas aplicações. Isto se deve a associatividade. No caso de múltiplas operações de mesma precedência, este grupo define que as operações devem ser realizadas da direita para a esquerda. Como temos dois modificadores na direita haverá um erro ao tentar aplicar o operando sobre Modifier <~ Modifier.
 */

//Esta linha geraria um erro:
//let thisIsAnError = fixedDamage(10) <~ 2 |==| 6 / isCreature(.earth) <~ fixedDamage(1) / isCreature(.evil)

//: [Next](@next)
