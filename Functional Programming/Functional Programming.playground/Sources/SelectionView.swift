import Foundation
import UIKit


public class SelectionView:UIView {
    
    private let spacing = CGFloat(10.0)
    private var selectionView:UIStackView!
    private var numberOfElements:Int = 0
    private var thumbnails:[UIImageView]!
    
    
    /// Delegate to handle the item selection
    public var selectionDelegate:((Int)->Void)?
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    
    /// Initializer
    ///
    /// - Parameter numberOfElements: NUmber of slots for selection
    public init(_ numberOfElements: Int) {
        super.init(frame:CGRect(x:0,y:0,width:10,height:10))
        self.numberOfElements = numberOfElements
        setupView()
    }
    
    //MARK: - Setup
    
    
    /// Setup the selection view
    private func setupView() {
        
        addSelectionView()
        
        addHeightConstraint()
        addSelectionViewConstraints()
        
        setupImageViews()
        
    }
    
    
    /// Prepare the slots (images)
    private func setupImageViews() {
        
        thumbnails = (0...(numberOfElements-1)).map { (index) -> UIImageView in
             let view = UIImageView()
            view.tag = index
            view.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action:  #selector (SelectionView.tapImage (_:)))
            view.addGestureRecognizer(tap)
            view.contentMode = .scaleAspectFit
    
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.borderWidth = 1.0
            
            selectionView.addArrangedSubview(view)
            
            return view
        }
        
    }
    
    @objc
    func tapImage(_ tap:UITapGestureRecognizer) {
        
        let selectedView = tap.view!.tag
        
        //Change borderChange
        for i in (0...(numberOfElements-1)) {
           thumbnails[i].layer.borderWidth =  (thumbnails[i].tag == selectedView) ?  3.0 : 1.0
            
        }
        //Fire delegate
        selectionDelegate?(selectedView)
    }
    
    // MARK: - Auxiliary Methods
    
    
    /// Add the selection  subview
    private func addSelectionView() {
        selectionView = UIStackView()
        selectionView.axis = .vertical
        selectionView.distribution = .fillEqually
        selectionView.spacing = spacing
        
        self.translatesAutoresizingMaskIntoConstraints = false
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(selectionView)
    }
    
    /// Create the selction view constraints
    private func addSelectionViewConstraints() {
        let selectionViewTop = NSLayoutConstraint(item:selectionView,attribute:.top, relatedBy:.equal,toItem: self,attribute:.top, multiplier:1, constant:0)
        
        let selectionViewBottom = NSLayoutConstraint(item:selectionView,attribute:.bottom, relatedBy:.equal,toItem: self,attribute:.bottom, multiplier:1, constant:0)
        
        let selectionViewLeading = NSLayoutConstraint(item:selectionView,attribute:.leading, relatedBy:.equal,toItem: self,attribute:.leading, multiplier:1, constant:0)
        let selectionViewTrailing = NSLayoutConstraint(item:selectionView,attribute:.trailing, relatedBy:.equal,toItem: self,attribute:.trailing, multiplier:1, constant:0)
        
        self.addConstraints([selectionViewTop, selectionViewBottom,selectionViewLeading, selectionViewTrailing])
    }
    
    private func addHeightConstraint() {
        let viewHeight = NSLayoutConstraint(item:self,attribute:.height, relatedBy:.equal,toItem: self,attribute:.width, multiplier:CGFloat(numberOfElements), constant:CGFloat(numberOfElements-1) * spacing)
        
        self.addConstraint(viewHeight)
    }
    
    //MARK: - Set image
    
    /// Set the image for a slot
    ///
    /// - Parameters:
    ///   - index: Selection slot
    ///   - image: Image to be associated with this slot
    func setImage(for index:Int, image:UIImage?) {
        guard (index >= 0 && index < numberOfElements) else {return}
        thumbnails[index].image = image
    }
    
}
