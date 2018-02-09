//: Playground - noun: a place where people can play
/*:
 #Exercícios
 */
import Foundation
//import "Exercicios"

let products = Products.setupProducts()
/*
 **Exercício 1** - Crie uma lista de produtos que não causam reação na pessoa. Calcule a incidência de ingredientes nesta lista e compare com a lista de produtos alergênicos (subtraindo ou a quantidade de aparecimentos ou ou percentual um do outro). Apresente a lista de candidatos a alérgenos baseado nesta nova contabilização.
 
**Exercício 2** - Dado o nome de um ingrediente (ou id), encontre todos os produtos que contém aquele ingrediente.
 
**Exercício 3** - Crie uma lista alfabética ordenada dos ingredientes presentes em uma lista de produtos dada (seja ela a lista de alergênicos ou dos produtos ok)

 */

//ex1
let restrictedProducts = [products[0], products[2], products[4], products[7], products[1], products[6]]

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
let restrictedIngredientCount = alergenicCandidates.reduce([Ingredient:Int]()) { (partialCount, ingredient) -> [Ingredient:Int] in
    return partialCount.merging([ingredient : 1], uniquingKeysWith: { (partialCount, newValue) -> Int in
        partialCount + newValue
    })
}

restrictedIngredientCount.sorted(by: { (ingredient1, ingredient2 ) -> Bool in
    return ingredient1.value > ingredient2.value
})


let notRestrictedProducts = products.filter( {(product) -> Bool in
    !restrictedProducts.contains(product)
})

let notAlergicCandidatesPart1 = notRestrictedProducts.flatMap({ (product) -> [Ingredient]? in
    product.ingredients
})

let notAlergicCandidates = notAlergicCandidatesPart1.flatMap{$0}

let notRestrictedIngredientCount = notAlergicCandidates.reduce([Ingredient: Int]()) { (partialCount, ingredient) -> [Ingredient: Int] in
    return partialCount.merging([ingredient: 1], uniquingKeysWith: { (count, newValue) -> Int in
        return count + newValue
    })
}

notRestrictedIngredientCount.sorted(by: { (ingredient1, ingredient2 ) -> Bool in
    return ingredient1.value > ingredient2.value
})



var newAlergicCandidates = restrictedIngredientCount.merging(notRestrictedIngredientCount, uniquingKeysWith: { (alergic, notAlergic) -> Int in
        return notAlergic - alergic
    })

let newAlergicCandidatesSorted = newAlergicCandidates.sorted(by: { (ingredient1, ingredient2 ) -> Bool in
    return ingredient1.value > ingredient2.value
})


restrictedIngredientCount
notRestrictedIngredientCount

newAlergicCandidatesSorted

//ex2
func product(contains ingredient: Ingredient) -> [Product] {
    return products.filter({ (product) -> Bool in
        return product.ingredients?.contains(ingredient) ?? false
    })
}

//ex3
func ingredients(of products:[Product]) -> [Ingredient] {
    var ingredients : [Ingredient] = [Ingredient]()
    
    for product in products {
        if let productIngredients = product.ingredients {
            let ingredientsToAppend = productIngredients.filter({ (ingredient) -> Bool in
                return !(ingredients.contains(ingredient))
                })
            
            ingredients.append(contentsOf: ingredientsToAppend)
        }
    }
    
    return ingredients
}


//test

//ex2
let ingredientTest = products.first?.ingredients?.first
if let ingredientTest = ingredientTest {
    product(contains: ingredientTest)
}

//ex3

let productsToGetIngredients = [products.first!, products.last!]
ingredients(of: productsToGetIngredients)


