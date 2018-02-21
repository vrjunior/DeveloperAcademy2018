//
//  ProductDataStore.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import Foundation


protocol ProductDataStore {
    
    func saveProduct(product:Product)
    
    func retrieveProductList() -> [Product]?
    
}
