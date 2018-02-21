//
//  AddProductInteractor.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit


//MARK: Interfaces
protocol AddProductInteractorInput
{
    func addProduct(request: AddProduct.Request)
}

protocol AddProductInteractorOutput
{
    func productSaved(response: AddProduct.Response)
}


//MARK: Implementation

///This class is part of the "Interactor" layer on the V**I**PER architecture.
///It is responsible for processing the technology-independent business logic (the
///use case itself).
class AddProductInteractor: NSObject, AddProductInteractorInput {
    
    ///This variable connects the Interactor to
    ///the technology-independent UI class. It is associated
    ///to an interface in order to keep it loose coupled to
    ///other pieces of code. This interface will be implemented,
    ///usually, by a Presenter class.
    var output: AddProductInteractorOutput?
    
    ///This variable holds the persistence layer, responsible for
    ///saving (create, delete, update) and retrieving the products
    var productStore: ProductDataStore?
    
    
    func addProduct(request: AddProduct.Request) {
        
        //validate Product
        
        //save 
        productStore?.saveProduct(product: Product(name: request.name, checked: false))
        
        //notify user interface that operation was completed
        output?.productSaved(response:AddProduct.Response())
        
    }

}
