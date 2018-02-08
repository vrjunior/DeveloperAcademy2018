//: [Previous](@previous)
/*:
 # Funções de alta ordem para coleções
 ## Exemplo
 */
import Foundation
let products = Products.setupProducts()
let restrictedProducts = [products[0], products[2], products[4], products[7], products[1], products[6]]

/*:
 Como exemplo do uso de funções de alta ordem em coleções vamos imaginar uma lista de produtos alergênicos para uma pessoa e tetar descobrir quais dos ingredientes presentes nestes aparece mais frequentemente, sendo um indício de que este ingrediente é o possível alérgeno.
 */
/*:
 Vamos inicialmente criar uma lista de todas as ocorrência de um dado ingrediente nos produtos listados. Como temos uma estrutura onde um produto tem a lista de seus ingredientes podemos utilizar o flat map para linearizar tal lista:
 */
let alergenicCandidatesPart1 = restrictedProducts.flatMap { (product) -> [Ingredient]? in
    product.ingredients
}
/*:
 Como esta lista pode conter opcionais, precisamos submetê-la novamente ao flat map para eliminar este segundo "envelope":
 */
let alergenicCandidates = alergenicCandidatesPart1.flatMap{$0}
/*:
 Vamos agora contabilizar os ingredientes nesta lista. Podemos reduzir a lista a um dicionário com o ingrediente e sua contagem.
 */
let ingredientCount = alergenicCandidates.reduce([Ingredient:Int]()) { (partialCount, ingredient) -> [Ingredient:Int] in
    return partialCount.merging([ingredient : 1], uniquingKeysWith: { (partialCount, newValue) -> Int in
        partialCount + newValue
    })
}
/*:
 Neste passo utilizamos uma nova função de alta ordem: **merging(_:uniquingKeysWith:)**. Esta função do dicionário combina dois dicionários (de forma imutável), aceitando como parâmetro uma função que define a regra de combinação no caso de chaves coincidentes.
 */
/*:
 Podemos agora ordenar este dicionário, gerando uma lista dos produtos por número de vezes que este apareceu:
 */
let sortedKeyValueList = ingredientCount.sorted { (ingredient1, ingredient2) -> Bool in
    ingredient1.value > ingredient2.value
}
/*:
 Esta lista retorna pares chave x valor. Vamos mapear esta lista para uma mais significativa com tuplas contendo o produto e a porcentagem de ocorrência na lista de produtos:
 */
let sortedList = sortedKeyValueList.map { (keyValuePair) -> (ingredient:Ingredient, percentage:Double) in
    (ingredient:keyValuePair.key, percentage:(Double(keyValuePair.value)/Double(restrictedProducts.count)) * 100)
}

print(sortedList)

//: [Next](@next)
