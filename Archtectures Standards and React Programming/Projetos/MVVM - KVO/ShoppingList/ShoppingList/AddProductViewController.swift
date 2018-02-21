//
//  AddProductViewController.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit


///This class represents the add product view on a M**V**VM architecture.
@objc
class AddProductViewController: UIViewController {

    private var myContext = 0

    @IBOutlet weak var productName: UITextField!
    
    deinit {
       // viewModel?.removeObserver(self, forKeyPath: "productSaved")
    }
    
    
    var viewModel: AddProductViewModel? {
        willSet {
        }
        didSet {
            //Set KVOs to be notified when the view model changes.
            //In this particular case it just observers the productSaved attribute
            //hat indiciates whether the product was added to the list
            saveProductObserver = viewModel?.observe(\.productSaved, options:[.new]){ [weak self] (changedViewModel, productSaved) in
                if let productSaved = productSaved.newValue  {
                    if productSaved {
                        OperationQueue.main.addOperation({ [weak self] in
                            self?.navigationController?.popViewController(animated: true)
                        })
                    }
                }
            }
        }
    }
    
    var saveProductObserver: NSKeyValueObservation?
    
    //MARK: View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = AddProductViewModel()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func saveProduct(_ sender: AnyObject) {
        
        
        viewModel?.saveProduct(name: productName?.text)
    }
    


}
