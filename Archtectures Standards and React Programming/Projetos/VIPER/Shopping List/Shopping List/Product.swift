//
//  Product.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

///Domain-related data structure that represents a product
///within a product list
struct Product: CustomStringConvertible, Equatable {
    
    ///Product name
    var name:String
    
    ///Whether this product was already marked or not
    ///Usually indicates it was already bought or taken.
    var checked:Bool
    
    var description: String {
        return ("\(name)(\(checked))")
    }

}

func ==(lhs: Product, rhs: Product) -> Bool {
    
    return lhs.name == rhs.name
}
