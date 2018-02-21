//
//  ProductModel.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 14/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import Foundation
import RxSwift

struct ProductModel {
    
    static let shared = ProductModel()

    private let productsPublisher = PublishSubject<[Product]>()
    private let productPublisher = PublishSubject<Product>()
    
    private var datatore:ProductDataStore = FilePersistentProductDataStore()
    
}

extension ProductModel: ManageProductList {
    
    public var products: PublishSubject<[Product]> {
        
        get {
            return productsPublisher
        }
    }
    
    public func productList() {
        if let productList = datatore.retrieveProductList() {
            // Notifies change
            productsPublisher.onNext(productList)
        }
    }
    
}

extension ProductModel: AddProduct {
    
    public var changeOnProduct: PublishSubject<Product> {
        
        get {
            return productPublisher
        }
    }
    
    public func saveProduct(product: Product) {
        datatore.saveProduct(product: product)
        // Notifies change
        productPublisher.onNext(product)
    }
    
}
