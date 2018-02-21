//
//  AddProductPresenter.swift
//  ShoppingListMVC
//
//  Created by Marcelo Reina on 02/08/16.
//  Copyright © 2016 Marcelo Reina. All rights reserved.
//

import UIKit

protocol AddProductPresenterView: class {
    func didCreateProduct()
    func didFailCreatingProduct(errorMessage: String)
}

class AddProductPresenter: NSObject {
    
    private weak var view: AddProductPresenterView! //should be weak to avoid retain cycle!
    
    init(view: AddProductPresenterView) {
        self.view = view
    }
    
    func saveProductAction(name: String) {
        //validate name
        guard !name.isEmpty else {
            //notify the view
            view.didFailCreatingProduct(errorMessage: "Product must have a name!")
            return
        }
        
        //create new product
        let product = Product(name: name, checked: false)
        
        //check if the new product is already in the list
        let dataStore = FilePersistentProductDataStore()
        if let products = dataStore.retrieveProductList() {
            let sameProducts = products.filter { (currentProduct) -> Bool in
                return currentProduct == product
            }
            guard sameProducts.count == 0 else {
                //notify the view
                view.didFailCreatingProduct(errorMessage: "\(name) is already in the list!")
                return
            }
        }
        
        //save
        dataStore.saveProduct(product: product)
        
        //notify the view
        view.didCreateProduct()
    }
    
}
