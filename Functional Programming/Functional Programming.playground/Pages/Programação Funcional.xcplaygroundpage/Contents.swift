//: [Previous](@previous)
/*:
 # Programação Funcional
 */
//: Programação funcional é um paradigma de programação que representa
//: problemas computacionais como um conjunto de funções (como funções
//: matemáticas) que podem se compor para atingir resultados mais complexos.
//:
//: Esta abordagem lida com funções de forma *declarativa*, definindo
//: *o que* é a função em termos de seus parâmetros de entrada e resultados e
//: não pensando em *como* os dados de entrada devem ser processados para gerar
//: o resultado. Esta última é a chamada abordagem imperativa seguida pelos
//: paradigmas procedural e orientado a objetos.
//:
//: Programação funcional é esturturada de forma que uma função não
//: mude o estado de nada fora de eu escopo, agindo como uma *caixa
//: preta*.  Os pontos de contato com o "mundo exterior" são apenas os
//: parâmetros e os resultados. Isso elimina problemas de  efeitos
//: colaterais" que ocorrem quando informação de estado é
//: compartilhada em programas desenvolvidos utilizando paradigmas
//: procedural ou orientado a objeto, em especial em casos de concorrência.
//:
//: - Note: Swift não é uma linguagem puramente funcional. Ela é
//: considerada uma linguagem multi-paradigma que mistura, em
//: diferentes níveis, características de diversos paradigmas.
//:
//: Em termos de programação funcional, as seguintes características estão presentes em Swift:
//:
/*: Swift trata funções como **cidadãos de primeira-classe**, isso significa que elas podem ser passadas como parâmetros e retornadas como resultados. Isso permite a criação e uso de funções de **alta-ordem**
 */
//: * Funções podem ser atribuídas a variáveis ou constantes em Swift
//: * Swift permite a utilização de dados imutáveis.
//: * Swift supporta funções anônimas (funções-λ - funções lambda)
//: * Uma boa linguagem funcional faz um uso cuidadoso da tipagem de dados Swift tem um sistema de tipos poderoso que pode auxiliar no desenvolvimento quando utilizamos uma abordagem funcional.
//: * Swift tem suporte a *pattern matching* como nos exemplos a seguir:
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]

// Correspondência apenas com valores não nulos (nil)
for case let number? in arrayOfOptionalInts {
    print("Found a \(number)")
}

var x:Any = 1

// Correspondência com um tipo específico
let isAnInteger = 1 is Int
let z = x as? Int

let point = (1, 2)
switch point {
case (0, 0):
    print("(0, 0) is at the origin.")
// Correspondência com uma faixa
case (-2...2, -2...2):
    print("(\(point.0), \(point.1)) is near the origin.")
default:
    print("The point is at (\(point.0), \(point.1)).")
}

//: [Next](@next)
