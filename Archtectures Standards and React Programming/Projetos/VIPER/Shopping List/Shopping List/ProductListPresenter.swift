//
//  ProductListPresenter.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/27/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

//MARK: Interfaces
protocol ManageProductListPresenterUserInterfaceInput
{
    func displayProductList(request: ManageProductList.Request)
    func changeProductSelection(product:ManageProductList.ViewModel.DisplayedProduct)
}

protocol ManageProductListPresenterUserInterfaceOutput:class
{
    func presentProductList(viewModel: ManageProductList.ViewModel)

}


protocol ManageProductListPresenterBusinessOutput
{
    func displayProductList(request: ManageProductList.Request)
}

protocol ManageProductListPresenterBusinessInput:class
{
    func retrieveProductList(request: ManageProductList.Request)
    func changeProductSelection(request:ManageProductList.Request)
    
}

//MARK: Implementation

///This class is part of the "Presenter" layer on the VI**P**ER architecture.
///It is responsible for processing the technology-independent UI logic.
class ManageProductListPresenter: NSObject {

    ///This variable connects the Presenter to
    ///the technology-dependent UI view. It is associated
    ///to an interface in order to keep it loose coupled to
    ///other pieces of code. This interface will be implemented,
    ///usually, by a View Controller class.
    weak var userInterface: ManageProductListPresenterUserInterfaceOutput?
    
    ///This variable connects the Presenter to
    ///the business logic (use case). It is associated
    ///to an interface in order to keep it loose coupled to
    ///other pieces of code. This interface will be implemented,
    ///usually, by an Interactor class.
    var businessInterface: ManageProductListPresenterBusinessInput?
    

    
}

//This extension implements the input from the technology-dependent UI logic
//to the presenter layer.
extension ManageProductListPresenter: ManageProductListPresenterUserInterfaceInput {
    
    func displayProductList(request: ManageProductList.Request) {
        
        businessInterface?.retrieveProductList(request: request)
        
    }
    
    func changeProductSelection(product:ManageProductList.ViewModel.DisplayedProduct) {
        
        let changedProduct = Product(name: product.name, checked: product.checked)
        
        businessInterface?.changeProductSelection(request:ManageProductList.Request.CheckProduct(product: changedProduct))
    }
}


//This extension implements the output from the business logic back
//to the presenter layer.
extension ManageProductListPresenter: ManageProductListPresenterBusinessOutput{
    
    func presentProductList(response: ManageProductList.Response) {
        let productList = response.products
        
        //Convert use case data to UI data
        let convertedList = productList?.map({ (product) -> ManageProductList.ViewModel.DisplayedProduct in
            return ManageProductList.ViewModel.DisplayedProduct(name: product.name, checked: product.checked)
        })
        
        let displayedList = ManageProductList.ViewModel(productList: convertedList)
        
        
        userInterface?.presentProductList(viewModel: displayedList)
    }
    
}

//This extension handles a notification that a product was saved, thus
//the interface should be updated accordingly.
extension ManageProductListPresenter: AddProductDelegate {
    
    func addProductDidSaveAddAction() {
        
        //Reload list and present it
        businessInterface?.retrieveProductList(request: ManageProductList.Request.ProductList())
        
    }
    
}
