//: [Previous](@previous)
/*:
 # Composição de funções
 */
import Foundation
let game = Game()
/*:
 Vamos melhorar a legibilidade da composição de funções criando novas funções que deixam os elementos mais claros:
 */
func apply(modifier:Modifier, to:@escaping Damage) -> Damage {
   return modifier(to)
}

let damage =  apply(modifier: dices(number: 1, sides: 6), to: fixedDamage(10))
let complexDamage = apply(modifier: dices(number: 2, sides: 4), to: damage)

game.set(damage: damage, for: .sword)
game.set(damage: complexDamage, for: .axe)

//: [Next](@next)
