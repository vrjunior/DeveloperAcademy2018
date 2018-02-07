import Foundation
import PlaygroundSupport
import UIKit


/// This structure represents visually an enemy
struct EnemyRepresentation {
    var enemy:Enemy
    var image:UIImage?
    var thumbnail:UIImage?
}

public enum Weapon:Int {
    case axe
    case sword
    case dagger
    case saber
}


public class Game {
    
    //MARK: - Image sets
    
    let typeImages = [UIImage(named:"earth"),
                      UIImage(named:"air"),
                      UIImage(named:"water"),
                      UIImage(named:"fire")]
    
    let alignmentImages = [UIImage(named:"good"),
                           UIImage(named:"neutral"),
                           UIImage(named:"evil")]
    
    var viewController:CombatViewController!
    
    var enemies:[EnemyRepresentation]
    var weaponDamages:[Damage?]
    
    var selectedEnemy:Int? = nil
    var selectedWeapon:Int? = nil
    
    var character = RPGCharacter(name:"Herói", strength:10, dextery:8)
    
    
    public init() {
        viewController = CombatViewController()
        PlaygroundPage.current.liveView = viewController
        
        
        enemies = [EnemyRepresentation]()
        weaponDamages = (0...4).map {(index) -> Damage? in nil}
        
        
        setupEnemies()
        prepareEnemyThumbnails()
        prepareWeapon()
        viewController.delegate = self
    }
    
    //MARK: - Setup environment
    
    
    /// Prepare the weapons list
    private  func prepareWeapon() {
        var image = UIImage(named:"axe")
        viewController.setImage(weapon:0, image:image)
        image = UIImage(named:"sword")
        viewController.setImage(weapon:1, image:image)
        image = UIImage(named:"dagger")
        viewController.setImage(weapon:2, image:image)
        image = UIImage(named:"sabre")
        viewController.setImage(weapon:3, image:image)
    }
    
    
    /// Prepare enemy thumbnails
    private func prepareEnemyThumbnails() {
        
        for index in 0..<enemies.count {
            viewController.setImage(enemy:index, image:enemies[index].thumbnail)
        }
    }
    
    /// Set the enemy list
    private func setupEnemies() {
        var enemy = Enemy(name:"Centaur",alignment:.good, type:.earth)
        var enemyRepresentation = EnemyRepresentation(enemy:enemy,image:UIImage(named:"centaur"), thumbnail:UIImage(named:"centaur-silhouette"))
        enemies.append(enemyRepresentation)
        enemy = Enemy(name:"Dragon",alignment:.neutral, type:.fire)
        enemyRepresentation = EnemyRepresentation(enemy:enemy,image:UIImage(named:"dragon"), thumbnail:UIImage(named:"dragon-silhouette"))
        enemies.append(enemyRepresentation)
        enemy = Enemy(name:"Troll",alignment:.evil, type:.earth)
        enemyRepresentation = EnemyRepresentation(enemy:enemy,image:UIImage(named:"troll"), thumbnail:UIImage(named:"troll-silhouette"))
        enemies.append(enemyRepresentation)
    }
    
    
}

extension Game:CombatViewControllerDelegate {
    
    
    /// Handle the enemy selection
    ///
    /// - Parameter index: Selected enemy index
    public func enemySelected(_ index:Int) {
        let enemy = enemies[index]
        
        viewController.setEnemy(enemy.image)
        viewController.setAlignment(alignmentImages[enemy.enemy.alignment.rawValue])
        viewController.setType(typeImages[enemy.enemy.type.rawValue])
        selectedEnemy = index
    }
    
    
    /// Handle the weapon selection
    ///
    /// - Parameter index: Selected weapon index
    public func weaponSelected(_ index:Int) {
        selectedWeapon = index
    }
    
    
    /// Simulates a hit in the enemy
    public func hit() {
        
        if let enemyIndex = selectedEnemy, let weaponIndex = selectedWeapon {
            let enemy = enemies[enemyIndex].enemy
            if let damage = weaponDamages[weaponIndex] {
                let hitPoints = damage(character,1,enemy)
                viewController.animateDamage(hitPoints:hitPoints)
            }
        }
    }
}


extension Game {
    
    /// Set the damage for a given weapon
    ///
    /// - Parameters:
    ///   - damage: Damage function evaluator
    ///   - weaponIndex: Weapon index
    public func set(damage:@escaping Damage,for weaponIndex:Weapon) {
        weaponDamages[weaponIndex.rawValue] = damage
    }
}



