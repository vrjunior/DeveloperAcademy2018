//
//  AddProductPresenter.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

//MARK: Interfaces
protocol AddProductPresenterUserInterfaceInput
{
    func saveProduct(request: AddProduct.Request)
}

protocol AddProductPresenterUserInterfaceOutput:class
{

}


protocol AddProductPresenterBusinessInput
{
    func productSaved(response: AddProduct.Response)
}

protocol AddProductPresenterBusinessOutput:class
{
    func addProduct(request: AddProduct.Request)
}

//MARK: Implementation

///This class is part of the "Presenter" layer on the VI**P**ER architecture.
///It is responsible for processing the technology-independent UI logic.
class AddProductPresenter: NSObject {
    
    ///This variable connects the Presenter to
    ///the business logic (use case). It is associated
    ///to an interface in order to keep it loose coupled to
    ///other pieces of code. This interface will be implemented,
    ///usually, by an Interactor class.
    var businessInterface:AddProductPresenterBusinessOutput?
    
    ///This variable connects the Presenter to
    ///the technology-dependent UI view. It is associated
    ///to an interface in order to keep it loose coupled to
    ///other pieces of code. This interface will be implemented,
    ///usually, by a View Controller class.
    var userInterface:AddProductPresenterUserInterfaceOutput?
    
    
    ///This variable connects the Presenter to its router, responsible
    ///for controlling the UI navigation.
    var router: AddProductRouter?
    
    ///This variable holds the delegate that can be notified when
    ///the product is added.
    var delegate: AddProductDelegate?


}

//This extension implements the input from the technology-dependent UI logic
//to the presenter layer.
extension AddProductPresenter: AddProductPresenterUserInterfaceInput {
    
    
    func saveProduct(request: AddProduct.Request) {
        
        businessInterface?.addProduct(request: request)
        
    }
    
}

//This extension implements the input from the use-case business logic
//to the presenter layer.
extension AddProductPresenter: AddProductPresenterBusinessInput {
    
     func productSaved(response: AddProduct.Response) {
        
        //Notify interface and navigate back to the scene that
        //fired this process.
        delegate?.addProductDidSaveAddAction()
        router?.dismissAddInterface()

    }
    
}
