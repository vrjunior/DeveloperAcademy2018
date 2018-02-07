//: [Previous](@previous)
/*:
 # Composição de funções
 */
import Foundation
let game = Game()
/*:
 Composição de funções é a aplicação pontual de uma função ao resultado de outra, produzindo assim uma terceira função. Consideremos, por exemplo *f*:(X) → Y e *g*:(Y) → Z, podemos criar uma função composta *h* tal que *h*:(X) → Z onde *h* = *g*(*f*(X)).
 
 No contexto das regras de dano de RPG existem modificadores que podem ser aplicados em determinadas condições para aumentar (ou diminuir) o dano de uma dada arma. Podemos fazer isto pensando em um tipo novo de funções modificadoras que pegam um dano base e transformam em um novo dano. Desta forma teremos uma função *M*, tal que *M*(*dano*) → *dano*, permitindo que componhamos danos mais complexos.
 */

typealias Modifier = (@escaping Damage) -> Damage

/*:
 A palavra **@escaping** indica que a *closure* que está sendo passada como parâmetro pois ela ainda existe após o retorno da função **Modifier**, desta forma ela "escapa" ao escopo da função.
 */

/*:
 Vamos criar um modificador que adiciona um número de dados a uma dano base:
 */
func dices(number:Int, sides:Int) -> Modifier {
    
    let damageModification:Damage = dices(number: number, sides: sides)
    
    return { (baseDamage) -> Damage in
        return { (character, distance, enemy) -> Int in
            return baseDamage(character, distance, enemy) + damageModification(character, distance, enemy)
        }
    }
}

//10 + 1d6
let damage = dices(number: 1, sides: 6)(fixedDamage(10))

/*:
 Veja a construção deste comando, onde temos *dices*:(X,Y) → M e *M*:(*fixedDamage*) → *novoDano*. Esta função será aplicada aos parâmetros de jogo (personagem, distância e inimigo) para entar retornar o valor do dano. Desta forma estamos compondo o novo dano como *M*:(*dano*) → *novoDano*:((personagem, distância, inimigo) → N). A sintaxe e legibilidade pode ficar complexa a medida que adicionamos novos modificadores:
 */

//10 + 1d6 + 1d4
let complexDamage = dices(number: 2, sides: 4)(dices(number: 1, sides: 6)(fixedDamage(10)))

/*:
Aqui temos uma composição *M*(*M*(*fixedDamage*)). Apesar da complexidade que se cria a composição de funções permite a criação de comportamento bem complexos utilizando como base funções simples.
 */

game.set(damage: damage, for: .axe)

//: [Next](@next)
