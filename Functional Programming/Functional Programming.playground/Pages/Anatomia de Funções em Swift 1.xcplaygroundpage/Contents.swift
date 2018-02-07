/*:
 # Anatomia de Funções em Swift
 */
 import UIKit
/*:
 
 Em Swift, funções são "cidadãs de primeira classe", o que significa serem tipos de dados similares
 a qualquer outro da linguagem, podendo ser atribuídas a variáveis ou constantes, passadas como parâmetro de outras funções e retornadas como resultado destas.
 
 Uma função é definida como sendo um trecho auto-contido de código que execute uma tarefa específica. Para tal ela precisa ser definida em termos de suas entradas (parâmetros), saída (valor de retorno) e código a ser executado. Sua utilizada é feita em um segundo momento pela chamada da função, que envolve definir os parâmetros que ela utilizará nesta dada execução, permitir sua execução e coletar o resultado desta.

 Vamos ver inicialmente a estrutura básica de uma função em Swift:
 */
func multiplyBy2 (multiplier number:Int) -> Int {
    return number * 2
}

multiplyBy2(multiplier: 3)

/*:
 A função *multiplyBy2* recebe um parâmetro inteiro e retorna como resultado também um número inteiro. Podemos dizer que este é o seu **tipo**: uma **função** que recebe um inteiro e retorna um inteiro, ou, na notação Swift: (Int)->Int.
 
 O parâmetro da função é rotulado externamente como *multiplier* e internamente como *number* (maneira como será utilizada no corpo da função). Podemos utilizar o mesmo nome tanto para o acesso interno quanto externo (utilizando apenas um rótulo neste caso) ou omitir seu uso externamente, definindo o nome externo como _:
*/

func multiplyBy3 (_ number:Int) -> Int {
    return number * 3
}

multiplyBy3(3)


//: [Next](@next)




