//
//  ProductList.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 16/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import Foundation
import RxSwift

protocol ManageProductList {
    
    
    /// Notifies changes on the product list or loaded
    var products: PublishSubject<[Product]> { get}
    
    /// Requests the product list
    func productList()
    
}
