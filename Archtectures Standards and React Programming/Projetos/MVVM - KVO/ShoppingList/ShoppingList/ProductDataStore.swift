//
//  ProductDataStore.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import Foundation

///This protocol creates an abstraction layer for a persistent product
///store. It allows data managing operations in a higher abstraction level,
///independent of the technology used to mantain these data (file, Core Data,
///another database, REST services etc.)
protocol ProductDataStore {
    
    ///Save a product
    func saveProduct(product:Product)
    
    ///Retrieve the list of products saved.
    func retrieveProductList() -> [Product]?
    
}
