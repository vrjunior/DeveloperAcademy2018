import Foundation

infix operator |==| : BitwiseShiftPrecedence

/*:
 Temos que definir a precedência de um operador. Como queremos que esta operação seja uma das mais altas na nossa hierarquia estou utilizando o grupo de precedência padrão mais alto (*Bitwise Shift*).
 Como um operador é uma função podemos agora implementá-lo
 */

public func |==| (lhs:Int, rhs:Int) -> Modifier {
    return dices(number: lhs, sides: rhs)
}

public func |==| (lhs:Int, rhs:Int) -> Damage {
    return dices(number: lhs, sides: rhs)
}
