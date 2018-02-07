//: [Previous](@previous)
/*:
 # Operadores customizados
 */
import Foundation
let game = Game()
/*:
 Vamos ajustar a associatividade do operador <~
 */
precedencegroup ModifierApplicationLeftGroup {
    lowerThan: AssignmentPrecedence
    associativity:left
}


infix operator <~ : ModifierApplicationLeftGroup

func <~ (lhs:@escaping Damage, rhs:Modifier) -> Damage {
    return apply(modifier: rhs, to: lhs)
}

let daggerDamage = fixedDamage(1) <~ fixedDamage(1) / isCreature(.evil)
let saberDamage = fixedDamage(10) <~ 2|==|6/isCreature(.earth) <~ fixedDamage(1)/isCreature(.evil)

game.set(damage: daggerDamage, for: .dagger)
game.set(damage: saberDamage, for: .saber)

//: [Next](@next)
