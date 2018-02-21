//
//  Product.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 14/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import Foundation

struct Product {
    
    ///Product name
    var name:String
    
    ///Whether this product was already marked or not
    ///Usually indicates it was already bought or taken.
    var checked:Bool
    
}

extension Product: CustomStringConvertible {
    var description: String {
        return ("\(name)(\(checked))")
    }
}


extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name
    }
}
