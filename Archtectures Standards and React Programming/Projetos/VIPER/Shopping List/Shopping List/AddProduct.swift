//
//  AddProduct.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/27/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import Foundation

///This struct represents the add product
///use case intermediate data structures
struct AddProduct {
    
    ///Responses when the use case is processed. For this particular
    ///example, the only response is the product list
    struct Response {
        
    }
    
    ///Requests for this use case processing. or this particular
    ///example, the only request is the product being added
    struct Request {
        
        var name: String
        
    }
    
    ///This structure represents the UI-related data. It allows decoupling
    ///the problem domain data to the UI data, so any extra information needed
    ///to present this piece of data will not be tainted.
    struct DataModel {
    }
    
}


///This protocol represents an external delegation to notify
///when the product is saved.
protocol AddProductDelegate {
    
    func addProductDidSaveAddAction()

    
}
