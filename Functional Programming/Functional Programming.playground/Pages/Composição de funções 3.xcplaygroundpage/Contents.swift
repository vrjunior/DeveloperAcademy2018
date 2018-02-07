//: [Previous](@previous)
/*:
 # Composição de funções
 */
import Foundation
let game = Game()
/*:
 Vamos criar modificadores mais complexos para mostrar a flexibilidade que composição nos permite.
 Imaginemos que existem modificadores que só se aplicam em alguns casos (dependendo do contexto). Vamos criar um tipo de função capaz de avaliar se dada regra é cumprida ou não. Façamos uma função *evaluationRule*:(personagem, distância, inimigo) → B, onde B é um valor booleano indicando se a regra é cumprida considerando o contexto. Com esta função podemos criar uma outra que dado um modificador e um avaliador de condição só o aplica se a condição for verdadeira. temos assim uma função *e*(*M*,*E*) → *M* se *E*(personagem, distância, inimigo) é verdadeiro e o modificador identidade, *I* (*I*(*dano*) → *dano*) caso contrário.
 */

typealias EvaluationRule = (RPGCharacter, Int, Enemy) -> Bool

func evaluate(modifier:@escaping Modifier, condition: @escaping EvaluationRule) -> Modifier {
    return { (damage) -> Damage in
        return { (character,distance,enemy) -> Int in
            let damageFunction =  condition(character,distance,enemy) ? modifier(damage) : damage
            return damageFunction(character,distance,enemy)
        }
    }
}

/*:
 Vamos criar algumas funções auxiliares para as regras de avaliação
 */

func isCreature(_ typeToVerify:CreatureType) -> EvaluationRule {
    return {  (character,distance,enemy) -> Bool in
        enemy.type == typeToVerify
    }
}

func isCreature(_ alignmentToVerify:Alignment) -> EvaluationRule {
    return {  (character,distance,enemy) -> Bool in
        enemy.alignment == alignmentToVerify
    }
}

/*:
 E podemos assim aplicar regras condicionais:
 */

let swordDamage = apply(modifier: evaluate(modifier: fixedDamage(5), condition: isCreature(.evil)), to: fixedDamage(1))
let axeDamage = apply(modifier: evaluate(modifier: dices(number: 2, sides: 6), condition: isCreature(.earth)), to: fixedDamage(10))

let daggerDamage = apply(modifier:fixedDamage(1), to: apply(modifier: evaluate(modifier: fixedDamage(1), condition: isCreature(.evil)), to: fixedDamage(1)))

game.set(damage: swordDamage, for: .sword)
game.set(damage: axeDamage, for: .axe)
game.set(damage: daggerDamage, for: .dagger)

//: [Next](@next)
