//
//  ProductListModel.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//
import Foundation

///Protocol that represents the manage product list model actions
protocol ManageProductList
{
    func items(_ completionHandler: ([Product]?) -> Void)
}
