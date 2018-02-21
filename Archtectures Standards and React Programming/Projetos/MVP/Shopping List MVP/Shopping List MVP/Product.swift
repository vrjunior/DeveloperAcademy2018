//
//  Product.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

struct Product: CustomStringConvertible, Equatable {
    
    var name:String
    var checked:Bool
    
    var description: String {
        return ("\(name)(\(checked))")
    }
    
}

func ==(lhs: Product, rhs: Product) -> Bool {
    
    return lhs.name == rhs.name
}
