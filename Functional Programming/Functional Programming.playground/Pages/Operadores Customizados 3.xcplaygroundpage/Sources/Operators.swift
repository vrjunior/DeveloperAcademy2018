import Foundation


public func / (lhs:@escaping Modifier, rhs: @escaping EvaluationRule) -> Modifier  {
    return evaluate(modifier: lhs, condition: rhs)
}


infix operator |==| : BitwiseShiftPrecedence


public func |==| (lhs:Int, rhs:Int) -> Modifier {
    return dices(number: lhs, sides: rhs)
}

public func |==| (lhs:Int, rhs:Int) -> Damage {
    return dices(number: lhs, sides: rhs)
}

precedencegroup ModifierApplicationGroup {
    lowerThan:AssignmentPrecedence
    associativity:right
}

infix operator ~> : ModifierApplicationGroup

public func ~> (lhs:Modifier, rhs:@escaping Damage) -> Damage {
    return apply(modifier: lhs, to: rhs)
}
