//
//  ProductList.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/27/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

///This struct represents the manage product list
///use case intermediate data structures
struct ManageProductList {
    

    ///Requests for this use case processing. We have
    ///two possibilities: request the product list, that has not associated
    ///parameters and check/uncheck a product, that has the product being changed
    ///as a parameter. Therefore, in this example, an enum with associated types
    ///is used to handle each one of the requests accordingly.
    enum Request {
        case ProductList()
        case CheckProduct(product:Product)
    }
    
    ///Responses when the use case is processed. For this particular
    ///example, the only response is the product list
    struct Response {
        
        var products: [Product]?
        
    }
    
    ///This structure represents the UI-related data. It allows decoupling
    ///the problem domain data to the UI data, so any extra information needed
    ///to present this piece of data will not be tainted.
    struct ViewModel
    {
        struct DisplayedProduct
        {
            var name: String
            var checked: Bool
        }
        
        var productList: [DisplayedProduct]?
    }
    
}


