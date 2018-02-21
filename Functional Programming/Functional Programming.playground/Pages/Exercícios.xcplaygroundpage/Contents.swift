//: [Previous](@previous)
/*:
 # Operadores customizados
 */
import Foundation
let game = Game()

// ex1
func doubleDamage() -> Modifier {
    return { (damage) -> Damage in
        return { (character, distance, enemy) -> Int in
            return 2 * damage(character, distance, enemy)
        }
    }
}


// ex2
func + (_ first: @escaping Damage, _ second: @escaping Damage) -> Damage {
    return { (character, distance, enemy) in
        return first(character, distance, enemy) + second(character, distance, enemy)
    }
}

func lostAllDamage() -> Modifier {
    return { (baseDamage) in
        return { (character, distance, enemy) in
            return 0
        }
    }
}


//let swordDamage1 = apply(modifier: evaluate(modifier: lostAllDamage(), condition: isCreature(.evil)), to: fixedDamage(1)) + fixedDamage(10)
//
//game.set(damage: swordDamage1, for: .sword)

let teste = doubleDamage()
let swordDamage = apply(modifier: teste, to: fixedDamage(10))

game.set(damage: swordDamage, for: .sword)


let lostDamage = fixedDamage(10) + dices(number: 3, sides: 6) <~ lostAllDamage() / isCreature(.evil) <~ fixedDamage(1)
game.set(damage: lostDamage, for: .sword)


let axeDamage = fixedDamage(20) + fixedDamage(100)
game.set(damage: axeDamage, for: .axe)

/*:
 **Exercício 1**: Crie um modificador que multiplica o dano base por um fator dado (por exemplo , dobrando no caso do fator ser 2).
 */
/*:
 **Exercício 2**: Crie uma função que some dois danos e crie (ou reutilize) um operador para ela.
 */
/*:
 **Exercício 3**: Faça com que seja possível "zerar" todo o dano base se uma regra for satisfeita. Modificadores posteriores a esta regra devem ser considerados.
 */

