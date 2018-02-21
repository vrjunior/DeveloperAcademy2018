//
//  AddProductModel.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

class AddProductModel: NSObject, AddProduct {
    
    var productStore: ProductDataStore?
    
    ///Add a product to the list
    ///
    ///- Parameter product: Product data to be added
    ///- Parameter completionHandler: Assynchronous closure to be executed after adding this product
    func addProduct(product:Product, completionHandler:()-> Void) {
        
        productStore?.saveProduct(product: product)
        completionHandler()
    }

}
