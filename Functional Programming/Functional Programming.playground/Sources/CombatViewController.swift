import Foundation
import UIKit

public protocol CombatViewControllerDelegate {
    func enemySelected(_ index:Int)
    func weaponSelected(_ index:Int)
    func hit()
}

public class CombatViewController:UIViewController {
    
    //MARK: - Outlets
    var enemySelectionView:SelectionView!
    var weaponSelectionView:SelectionView!
    var enemyView:UIImageView!
    var alignmentView:UIImageView!
    var typeView:UIImageView!
    var damageLabel:UILabel!
    
    // MARK: - Constants
    let enemySlots = 3
    let weaponSlots = 4
    
    let spacing = CGFloat(20)
    
    //MARK: - Delegate

    /// Delegate to handle the user interactions
    public var delegate:CombatViewControllerDelegate? = nil
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    
    override public func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
    }
    
    
    /// Setup  subviews
    private func setupViews() {
        
        self.view.backgroundColor = UIColor.white
        setupThumbnailView()
        setupEnemyView()
        setupDetailViews()
        setupDamageLabel()
        
        //set delegates
        enemySelectionView.selectionDelegate = enemySelected
        weaponSelectionView.selectionDelegate = weaponSelected
    }
    
    //MARK: - Function Delegates
    

    /// Handle the enemy selection
    ///
    /// - Parameter index: Enemy selected index
    func enemySelected(index:Int) {
        delegate?.enemySelected(index)
    }
    
    
    /// Handle the weapon selection
    ///
    /// - Parameter index: Weapon selected index
    func weaponSelected(index:Int) {
        delegate?.weaponSelected(index)
    }
    
    // MARK: - View Setup
    
    
    /// Set the selection views (enemy and weapon)
    private func setupThumbnailView() {
        
        
        enemySelectionView = SelectionView(enemySlots)
        weaponSelectionView = SelectionView(weaponSlots)
        
        self.view.addSubview(enemySelectionView)
        self.view.addSubview(weaponSelectionView)
        
        
        let enemyWidth = NSLayoutConstraint(item:enemySelectionView,attribute:.width, relatedBy:.equal,toItem: self.view,attribute:.width, multiplier:0.15, constant:0.0)
        let enemyLeading = NSLayoutConstraint(item:enemySelectionView,attribute:.leading, relatedBy:.equal,toItem: self.view,attribute:.leading, multiplier:1, constant:10.0)
        let enemyBottom = NSLayoutConstraint(item:enemySelectionView,attribute:.bottom, relatedBy:.equal,toItem: self.view,attribute:.bottom, multiplier:1, constant:-10.0)
        
        
        let weaponWidth = NSLayoutConstraint(item:weaponSelectionView,attribute:.width, relatedBy:.equal,toItem: self.view,attribute:.width, multiplier:0.1, constant:0.0)
        let weaponLeading = NSLayoutConstraint(item:weaponSelectionView,attribute:.trailing, relatedBy:.equal,toItem: self.view,attribute:.trailing, multiplier:1, constant:-10.0)
        let weaponBottom = NSLayoutConstraint(item:weaponSelectionView,attribute:.bottom, relatedBy:.equal,toItem: self.view,attribute:.bottom, multiplier:1, constant:-10.0)
        
        
        self.view.addConstraints([enemyWidth,enemyLeading,enemyBottom])
        self.view.addConstraints([weaponWidth,weaponLeading,weaponBottom])
        
    }
    
    
    /// Setup the main enemy image view
    private func setupEnemyView() {
        enemyView = UIImageView()
        
        enemyView.contentMode = .scaleAspectFit
        enemyView.isUserInteractionEnabled = true
        
        enemyView.translatesAutoresizingMaskIntoConstraints = false
       
        
        self.view.addSubview(enemyView)
        
        let width = NSLayoutConstraint(item:enemyView,attribute:.width, relatedBy:.equal,toItem: self.view,attribute:.width, multiplier:0.6, constant:0.0)
        let height = NSLayoutConstraint(item:enemyView,attribute:.height, relatedBy:.equal,toItem: enemyView,attribute:.width, multiplier:1, constant:0.0)
        let centerX = NSLayoutConstraint(item:enemyView,attribute:.centerX, relatedBy:.equal,toItem: self.view,attribute:.centerX, multiplier:1, constant:0)
        let centerY = NSLayoutConstraint(item:enemyView,attribute:.centerY, relatedBy:.equal,toItem: self.view,attribute:.centerY, multiplier:1, constant:0)
        
        self.view.addConstraints([width,height, centerX,centerY])
        
        let tap = UITapGestureRecognizer(target: self, action:  #selector (CombatViewController.tapImage (_:)))
        enemyView.addGestureRecognizer(tap)
    }
    
    
    /// Setup the details view (alignment + type)
    private func setupDetailViews()  {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        stackView.contentMode = .scaleAspectFit
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        let height = NSLayoutConstraint(item:stackView,attribute:.width, relatedBy:.equal,toItem: stackView,attribute:.height, multiplier:6, constant:0.0)
        let width = NSLayoutConstraint(item:stackView,attribute:.width, relatedBy:.equal,toItem: self.view,attribute:.width, multiplier:0.6, constant:0.0)
        let centerX = NSLayoutConstraint(item:stackView,attribute:.centerX, relatedBy:.equal,toItem: self.view,attribute:.centerX, multiplier:1, constant:0)
        let top = NSLayoutConstraint(item:stackView,attribute:.top, relatedBy:.equal,toItem: self.view,attribute:.top, multiplier:1, constant:10)
            self.view.addConstraints([width, height, centerX,top])
        
            alignmentView = setupDetailView()
            stackView.addArrangedSubview(alignmentView)

        
            typeView = setupDetailView()
            stackView.addArrangedSubview(typeView)

    }
    
    /// Setup the details' views
    private func setupDetailView() -> UIImageView {
        
        
        
        let detailView = UIImageView()
        detailView.contentMode = .scaleAspectFit
    
        return detailView
    }
    
    
    /// Setup the hit point label
    private func setupDamageLabel() {
        damageLabel = UILabel()
        damageLabel?.text = ""
        damageLabel.textColor = UIColor.green
        damageLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
       
        damageLabel.translatesAutoresizingMaskIntoConstraints = false
        damageLabel.alpha = 0
        
        self.view.addSubview(damageLabel)
        
        let centerX = NSLayoutConstraint(item:damageLabel,attribute:.centerX, relatedBy:.equal,toItem: enemyView,attribute:.centerX, multiplier:1, constant:0.0)
        let bottom = NSLayoutConstraint(item:damageLabel,attribute:.bottom, relatedBy:.equal,toItem: enemyView,attribute:.top, multiplier:1, constant:0)
         self.view.addConstraints([centerX,bottom])
        
    }
    
    @objc
    func tapImage(_ tap:UITapGestureRecognizer) {
        delegate?.hit()
    }
    
    
    //MARK: - Set images
    
    /// Set the enemy selection image
    ///
    /// - Parameters:
    ///   - enemy: Slot index
    ///   - image: Enemy image to be set
    public func setImage(enemy index:Int, image: UIImage?) {
        enemySelectionView.setImage(for:index, image:image)
    }
    
    /// Set the weapon selection image
    ///
    /// - Parameters:
    ///   - weapon: Slot index
    ///   - image: Weapon image to be set
    public func setImage(weapon index:Int, image: UIImage?) {
        weaponSelectionView.setImage(for:index, image:image)
    }
    
    
    /// Set the main enemy image
    ///
    /// - Parameter image: Enemy image to be set
    public func setEnemy(_ image:UIImage?) {
        enemyView.image = image
    }
    
    /// Set the alignment icon image
    ///
    /// - Parameter image: Alignment icon
    public func setAlignment(_ image:UIImage?) {
        alignmentView.image = image
    }
    
    
    /// Set the creature type icon image
    ///
    /// - Parameter image: Creature type icon 
    public func setType(_ image:UIImage?) {
        typeView.image = image
    }
    
    //MARK: - Animation
    
    
    /// Animate a hit in the enemy
    ///
    /// - Parameter hitPoints: Number of hit points
    public func animateDamage(hitPoints:Int) {
        self.damageLabel.text = "\(hitPoints) !"
        UIView.animate(withDuration: 0.5, animations: {
            self.damageLabel.alpha = 1
            self.damageLabel.transform = self.damageLabel.transform.scaledBy(x:2,y:2)
            self.damageLabel.transform = self.damageLabel.transform.translatedBy(x:0,y:-20)
        }, completion: { (cancelled) -> Void in
             self.damageLabel.alpha = 0
             self.damageLabel.transform = CGAffineTransform.identity
            self.damageLabel.text=""
        })
    }
    
    
}
