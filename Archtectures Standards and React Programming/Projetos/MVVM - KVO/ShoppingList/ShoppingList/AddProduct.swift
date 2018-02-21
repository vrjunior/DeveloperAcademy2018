//
//  AddProduct.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import Foundation

///Protocol that represents the add product model actions
protocol AddProduct {
    
    func addProduct(product:Product, completionHandler:()-> Void)
    
}
