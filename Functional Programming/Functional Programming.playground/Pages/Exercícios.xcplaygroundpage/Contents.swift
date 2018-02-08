//: [Previous](@previous)
/*:
 # Operadores customizados
 */
import Foundation
let game = Game()

//ex1
func doubleDamage(damage: Damage) -> Modifier {
    return { (damage) -> Damage in
        return { (character, distance, enemy) -> Int in
            return 2 * damage(character, distance, enemy)
        }
    }
}

//ex2
func + (_ first: @escaping Damage, _ second: @escaping Damage) -> Damage {
    return { (character, distance, enemy) in
        return first(character, distance, enemy) + second(character, distance, enemy)
    }
}

/*:
 **Exercício 1**: Crie um modificador que multiplica o dano base por um fator dado (por exemplo , dobrando no caso do fator ser 2).
 */
/*:
 **Exercício 2**: Crie uma função que some dois danos e crie (ou reutilize) um operador para ela.
 */
/*:
 **Exercício 3**: Faça com que seja possível "zerar" todo o dano base se uma regra for satisfeita. Modificadores posteriores a esta regra devem ser considerados.
 */

