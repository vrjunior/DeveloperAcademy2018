//: [Previous](@previous)
/*:
 # Sistema de Danos de RPG
 */
import Foundation
let game = Game()
/*:
Vamos criar uma regra simples de dano, que aplica um dano fixo a cada golpe bem sucedido da arma. Nossa preocupação neste sistema de regras é apenas o dano em si e não as regras de acerto, que poderiam ser desenvolvidas em uma abordagem similar.
 */
let swordDamage:Damage = { (character, distance, enemy) -> Int in
    return 20
}


let saberDamage:Damage = { (character, distance, enemy) -> Int in
    return 25
}


let axeDamage:Damage = { (character, distance, enemy) -> Int in
    return 30
}

let daggerDamage:Damage = { (character, distance, enemy) -> Int in
    return 10
}


game.set(damage: swordDamage, for: .sword)
game.set(damage: axeDamage, for: .axe)
game.set(damage: daggerDamage, for: .dagger)
game.set(damage: saberDamage, for: .saber)

//: [Next](@next)
