//: [Previous](@previous)
/*:
 # Exercício
 */
import Foundation
let game = Game()


//ex1
func roll(faces: Int) -> Damage {
    return { (character, distance, enemy) -> Int in
        return Int(arc4random_uniform(UInt32(faces - 1)) + 1)
    }
}

//ex2
func roll(dices:Int, faces: Int) -> Damage {
    
    return { (character, distance, enemy) -> Int in
        return Int(arc4random_uniform(UInt32(dices * faces - 1)) + 1)
    }
    
}


/*:
 **Exercício 1**: Crie uma função que gere um dano aleatório a cada chamada, simulando um dado. Permita que seja definido o número de faces do dado, resultando em um dano entre 1 e este número.
 */
/*:
 **Exercício 2**: Crie uma função que gere um dano aleatório para um número dado de dados e de faces.
 */
//: [Next](@next)
