//
//  File.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 16/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import Foundation
import RxSwift

protocol AddProduct {
    
    
    /// Stream that notifies changes on a specific product
    var changeOnProduct: PublishSubject<Product>  {get}
    
    /// Save a product on the proper persistent store
    func saveProduct(product: Product)
    
}
