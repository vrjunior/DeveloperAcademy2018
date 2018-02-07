/*:
 [Previous](@previous)
 # Closures
 */
import Foundation
/*:
Outro ponto importante sobre *closures* é o fato destas poderem acessar dados do escopo que as compreende, não apenas dos seus parâmetros.
 */
var x = 3
let myFunction = { () -> Void in
    print("Eu consigo ver o que se passa com x! \(x)")
}
myFunction()
x = 6
myFunction()

//: [Next](@next)
