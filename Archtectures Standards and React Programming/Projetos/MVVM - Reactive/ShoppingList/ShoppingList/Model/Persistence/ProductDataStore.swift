//
//  ProductDataStore.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 16/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import Foundation


/// General purpose data store CRUD interface
protocol ProductDataStore {
    
    ///Save a product
    func saveProduct(product:Product)
    
    ///Retrieve the list of products saved.
    func retrieveProductList() -> [Product]?
    
}
