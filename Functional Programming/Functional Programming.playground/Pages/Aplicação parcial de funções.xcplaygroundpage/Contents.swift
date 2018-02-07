//: [Previous](@previous)
/*:
 # Aplicação parcial de funções
 */
import Foundation
let game = Game()
/*:
 As funções criadas na página anterior eram todas muito similares, apenas com a mudança do valor. Em termos de reuso seria melhor termos apenas uma função com esta informação extra, porém ela deixaria de ser do tipo **Damage** que definimos neste caso.
 A solução para isto é a aplicação parcial de funções. A aplicação parcial de funções é a criação de uma função a partir de outra com mais parâmetros através da fixação de alguns destes parâmetros.
 
 Por exemplo, dada a função *f*:(X x Y x Z) → N, podemos aplicar uma função *parcial*:(*f*) → *g*, onde *g* é uma função *g*:(Y x Z) → N
 
 No nosso caso deveríamos ter uma função *dano'*:(Valor x Personagem x Distância x Inimigo) → Pontos. Vamos criar uma função chamada *fixedDamage*, tal que *fixedDamage*:(*Valor*) → ( *dano*(Personagem x Distância x Inimigo) → Pontos ).
 */

func fixedDamage(_ value:Int) -> Damage {
    return { (character, distance, enemy) -> Int in
        return value
    }
}

/*:
 Como uma *closure* mantém o contexto, o valor passado como parâmetro de **fixedDamage** será mantido em qualquer execução futura da função resultante.
 */

let swordDamage:Damage = fixedDamage(20)
let saberDamage = fixedDamage(25)
let axeDamage:Damage = fixedDamage(30)
let daggerDamage:Damage = fixedDamage(10)

game.set(damage: swordDamage, for: .sword)
game.set(damage: axeDamage, for: .axe)
game.set(damage: daggerDamage, for: .dagger)
game.set(damage: saberDamage, for: .saber)

//: [Next](@next)

