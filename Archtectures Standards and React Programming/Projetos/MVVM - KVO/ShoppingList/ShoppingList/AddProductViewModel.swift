//
//  AddProductViewModel.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit


//This class represents the view-model on a MV**VM** architecture. It handles
//the technology-independent presentation logic as well as the business rules
//associated with the add product functionality.
class AddProductViewModel: NSObject {

    var model: AddProductModel?
    
    //This variable indicates that the model-view state has changed in order
    //to notify the views interested on it. Any Key-Value field could be used
    //this way
    dynamic var productSaved : Bool = false
    
    override init() {
        model = AddProductModel()
        model?.productStore = FilePersistentProductDataStore()
    }
    
    ///Save a product into the list
    ///
    ///- Parameter name: Product name to be saved
    func saveProduct(name:String?) {
        
        self.productSaved = false
        
        guard let productName = name else {
            return
        }
        
        let product = Product(name: productName, checked: false)
        
        model?.addProduct(product: product, completionHandler: { [unowned self] in
            //Update view model state
            self.productSaved = true
        })
        
    }
    

    
}
