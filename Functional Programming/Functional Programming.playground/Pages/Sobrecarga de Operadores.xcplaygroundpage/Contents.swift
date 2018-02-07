//: [Previous](@previous)
/*:
 # Sobrecarga de Operadores
 */
import Foundation
let game = Game()
/*:
 Como a composição de funções acaba gerando muitos níveis de parênteses e dificultam a legibilidade, um recurso poderoso, porém perigoso para melhorar a legibilidade é a utilização de operadores.
 Em Swift podemos sobrescrever o comportamento dos operadores padrões do sistema e mesmo criar nossos próprios operadores.
 
- Note: Vale lembrar que este recurso pode dificultar a leitura de pessoas que não conhecem o código (como novos membros da equipe). Use este recurso com cuidado e documentando muito bem o código!
 */
/*:
 Vamos utilizar o operador / com uma semântica diferente para o modificador condicional. Ele terá o formato Modificador/Condição indicando que o modificador só será aplicado se a condição se aplicar
 */

func / (lhs:@escaping Modifier, rhs: @escaping EvaluationRule) -> Modifier  {
    return evaluate(modifier: lhs, condition: rhs)
}

let swordDamage = apply(modifier: fixedDamage(5)/isCreature(.evil), to: fixedDamage(1))
let axeDamage = apply(modifier: dices(number: 2, sides: 6)/isCreature(.earth), to: fixedDamage(10))

game.set(damage: swordDamage, for: .sword)
game.set(damage: axeDamage, for: .axe)


//: [Next](@next)
