//
//  AddProductViewModel.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 15/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import Foundation
import RxSwift

struct AddProductViewModel {
    
    //MARK: - Properties
    
    private var bag = DisposeBag()
    
    //MARK: - UI Outputs Streams
    let productAdded = PublishSubject<Product>()
    
    //MARK: - UI Input Streams
    let productName = PublishSubject<String?>()
    let addProductAction = PublishSubject<Void>()
    
    //MARK: - Model References
    var model:AddProduct?
    
    
    // MARK: - Initializers
    
    init() {
        model = ProductModel.shared
        bindToModel()
        bindUIOutputs()
    }
    
    // MARK: - Bindings
    
    func bindToModel() {
        
        //When product is saved, retransmit this
        model?.changeOnProduct.subscribe(onNext: { (product) in
            self.productAdded.onNext(product)
        }).disposed(by: bag)
        
    }
    
    func bindUIOutputs() {
        
        addProductAction
            .withLatestFrom(productName) //Merge add product button and last text typed
            .filter { (productName) -> Bool in
                productName != nil && productName!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0
            } //Just if there is any text
            .map({ (productName) -> Product in
                return Product(name: productName!, checked: false)
            }) // Convert event to a Product event stream
            .subscribe(onNext: { (product) in
                //Save product
                self.model?.saveProduct(product: product)
            }).disposed(by: bag)
    }
}
