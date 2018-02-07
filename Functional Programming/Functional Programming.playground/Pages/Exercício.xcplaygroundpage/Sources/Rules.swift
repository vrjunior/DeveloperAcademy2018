import Foundation

public struct RPGCharacter {
    var name:String
    //Aributos
    var strength:Int
    var dextery:Int
}

public enum CreatureType:Int {
    case earth, air, water, fire
}

public enum Alignment:Int {
    case good, neutral, evil
}

public struct Enemy {
    var name:String
    var alignment:Alignment
    var type:CreatureType
}

public typealias Damage = (RPGCharacter, Int, Enemy) -> Int

public func fixedDamage(_ value:Int) -> Damage {
    return { (character, distance, enemy) -> Int in
        return value
    }
}
