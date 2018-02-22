//
//  FilePersistentProduct.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 14/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import Foundation

public class FilePersistentProduct: NSObject, NSCoding {
    
    var name:String
    var type:Int32
    var checked:Bool = false
    
    public override  var description: String {
        return ("\(name) \(type) \(checked)")
    }
    
    convenience init(product: Product) {
        self.init(name:product.name, type:0, checked: product.checked)
    }
    
    public required init(name:String, type: Int32, checked:Bool) {
        self.name = name
        self.type = type
        self.checked = checked
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "productName") as! String
        type = aDecoder.decodeInt32(forKey: "productType")
        checked = aDecoder.decodeBool(forKey:"checked")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(type, forKey: "productType")
        aCoder.encode(name, forKey: "productName")
        aCoder.encode(checked, forKey: "checked")
    }
    
}