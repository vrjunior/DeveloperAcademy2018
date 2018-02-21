//
//  AddProductViewController.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

//MARK: Interfaces
protocol AddProductViewControllerInput
{
    //func productDidSave(viewModel: ProductList.ViewModel)
}

protocol AddProductViewControllerOutput
{
    func saveProduct(request: AddProduct.Request)
}


//MARK: Implementation

///This class is part of the "View" layer on the **V**IPER architecture.
///It is responsible for capture the users' interaction and passively present
///data back to them.
class AddProductViewController: UIViewController  {
    
    ///This variable connects the View Controller to
    ///the technology-independent UI logic. It is associated
    ///to an interface in order to keep it loose coupled to
    ///other pieces of code. This interface will be implemented,
    ///usually, by a Presenter class.
    var output : AddProductViewControllerOutput?
    
    ///The router controls the navigation from this View Controller
    ///to associated ones
    var router: AddProductRouter?
    
    @IBOutlet weak var nameTextField:UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let configurator = AddProductConfigurator()
        configurator.configure(viewController: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        if let name = nameTextField?.text {
             output?.saveProduct(request: AddProduct.Request(name: name))
        }
    }


}
