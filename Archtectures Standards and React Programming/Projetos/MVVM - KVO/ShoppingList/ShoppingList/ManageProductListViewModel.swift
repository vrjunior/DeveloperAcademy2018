//
//  ManageProductListViewModel.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

protocol ManageProductListViewDelegate: class
{
    func productsDidChange(viewModel: ManageProductListViewModel)
}

class ManageProductListViewModel: NSObject {
    
    override init() {
        model = ManageProductListModel()
        model?.productStore = FilePersistentProductDataStore()
    }
    
    
    var model: ManageProductListModel? {
        didSet {
            items = nil;
            model?.items({ (items) in
                self.items = items
            })
        }
    }
    
    //List of products being currently presented
    var items: [Product]? {
        willSet {
            listLoaded = false
        }
        didSet {
          listLoaded = true
        }
    }
    
    
    //This variable indicates that the model-view state has changed in order
    //to notify the views interested on it. Any Key-Value field could be used
    //this way
    dynamic var listLoaded:Bool = false
    
    ///Number of products presented on the list current being displayed
    var numberOfProducts:Int? {
        return self.items?.count
    }
    
    ///Retrieve the product list
    func displayProductList() {
        
        //The view-model queries the model in order to get a copy of
        //the update product list
        model?.items({ (items) in
            self.items = items
        })
        
    }
    
    ///Change the status (check/unchecked) of a product
    ///
    /// - Parameter index: Index of product that was changed on list
    func changeProductStatus(index:Int) {
 
        let product = items?[index]
        
        
        if product != nil {
            
            let productToBeSaved = Product(name: product!.name, checked: !(product!.checked))
            
            //The view-model asks the model  to update the product
            model?.saveProduct(product: productToBeSaved, completionHandler: { [unowned self] in
                self.displayProductList()
            })
        }
        
        
    }
    
}
