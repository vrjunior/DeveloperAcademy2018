//
//  ProductListModel.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

///This class implement the manage product list actions
class ManageProductListModel: NSObject, ManageProductList {
    
    var productStore: ProductDataStore?
    
    ///Retrieve product list items
    ///
    ///- Parameter completionHandler: Assynchronous closure to be executed after retrieving list
    func items(_ completionHandler: ([Product]?) -> Void) {
        
        let productList = productStore?.retrieveProductList()
        
        completionHandler(productList)
        
    }
    
    ///Save product
    ///
    ///- Parameter product: Product data to be saved
    ///- Parameter completionHandler: Assynchronous closure to be executed after saving this product
    func saveProduct(product:Product, completionHandler:()-> Void) {
        
        productStore?.saveProduct(product: product)
        completionHandler()
    }

}
