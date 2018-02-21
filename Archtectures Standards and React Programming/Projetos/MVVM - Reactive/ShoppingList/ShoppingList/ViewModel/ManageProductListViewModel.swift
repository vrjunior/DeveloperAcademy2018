//
//  ManageProductListViewModel.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 15/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import Foundation
import RxSwift


struct ManageProductListViewModel {
    
    //MARK: - Properties
    
    private var bag = DisposeBag()
    
    //MARK: - UI Output Streams
    let addProduct = PublishSubject<Void>()
    let editProduct = PublishSubject<Product>()
    let productList = BehaviorSubject<[Product]>(value:[])
    
    //MARK: - UI Input Streams
    let productChange = PublishSubject<Product?>()
    let productSelected = PublishSubject<Product>()
    
    //MARK: - Model References
    var listModel:ManageProductList?
    var addModel:AddProduct?
    

    // MARK: - Initializers
    
    init() {
        
        listModel = ProductModel.shared
        addModel = ProductModel.shared
        
        bindUIInputs()
        bindToModel()
        
        listModel?.productList()
    }
    
    
    // MARK: - Bindings
    
    func bindUIInputs() {
        
        //Change checked status of a product when selected
        productSelected
            .subscribe(onNext: { (product) in
                self.addModel?.saveProduct(product: Product(name: product.name, checked: !product.checked))
            })
            .disposed(by: bag)
        
        
        productChange
            .filter { (product) -> Bool in
                product == nil
            } //A new product was saved
            .map {_ -> Void in} // No further info is needed, just the event itself
            .bind(to:addProduct) // Binds to addProduct event stream to notify interested parts
            .disposed(by: bag)
        
        productChange
            .filter { (product) -> Bool in
                product != nil
            } //an existing product was changed
            .map { $0!} // replies the product to a product stream (product is not nil, forced unwrapped is ok)
            .bind(to:editProduct) // Binds to editProduct event stream to notify interested parts
            .disposed(by: bag)
        
    }
    
    func bindToModel() {
        //Broadcast the product list changes to interested parts connected to productList stream
        listModel?.products
            .bind(to: productList)
            .disposed(by: bag)
        
        //Updates list whenever a product changes
        addModel?.changeOnProduct
            .subscribe(onNext: { (_) in
                self.listModel?.productList()
            })
            .disposed(by: bag)
    }

    
}
