//
//  ProductListInteractor.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/27/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

//MARK: Interfaces
protocol ManageProductListInteractorInput
{
    func retrieveProductList(request: ManageProductList.Request)
    func changeProductSelection(request:ManageProductList.Request)
}

protocol ManageProductListInteractorOutput:class
{
    func presentProductList(response: ManageProductList.Response)
}

//MARK: Implementation

///This class is part of the "Interactor" layer on the V**I**PER architecture.
///It is responsible for processing the technology-independent business logic (the
///use case itself).
class ManageProductListInteractor: NSObject {
    
    ///This variable holds the persistence layer, responsible for
    ///saving (create, delete, update) and retrieving the products
    var productStore: ProductDataStore?
    
    ///This variable connects the Interactor to
    ///the technology-independent UI class. It is associated
    ///to an interface in order to keep it loose coupled to
    ///other pieces of code. This interface will be implemented,
    ///usually, by a Presenter class.
    weak var output: ManageProductListInteractorOutput?
    


}

//This extension implements the output from the business logic back
//to the presenter layer.
extension ManageProductListInteractor: ManageProductListInteractorInput {
    
    func retrieveProductList(request: ManageProductList.Request) {
        
        
        //retrieve product list
        let productList = productStore?.retrieveProductList()
        let response = ManageProductList.Response(products: productList)
        
        //Send it back to presenter
        output?.presentProductList(response: response)
        
    }
    
    func changeProductSelection(request:ManageProductList.Request) {
        
        //Handle the request only if it is a check product one.
        //The if case(let) allow us to, using pattern matching, retrieve
        //the enum associated values.
        if case ManageProductList.Request.CheckProduct(let product) = request {
            
            let changedProduct = Product(name: product.name, checked: !product.checked)
            
            productStore?.saveProduct(product: changedProduct)
            
            //Send it back to presenter
            retrieveProductList(request: ManageProductList.Request.ProductList())
        }
        
    }
}
