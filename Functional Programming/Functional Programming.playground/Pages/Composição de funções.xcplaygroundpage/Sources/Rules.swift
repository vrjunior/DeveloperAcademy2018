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

public func dice(sides:Int) -> Damage {
    return { (character, distance, enemy) -> Int in
        return Int(arc4random() % UInt32(sides)) + 1
    }
}

public func dices(number:Int, sides:Int) -> Damage {
    return (1...number).reduce({(character,distance,enemy) -> Int in 0}) { (partial,index) in
        { (character,distance,enemy) -> Int in
            partial(character,distance,enemy) + dice(sides:sides)(character,distance,enemy)
        }
    }
}
