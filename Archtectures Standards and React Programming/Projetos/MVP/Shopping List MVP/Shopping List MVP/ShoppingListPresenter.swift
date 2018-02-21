//
//  ShoppingListPresenter.swift
//  ShoppingListMVC
//
//  Created by Marcelo Reina on 02/08/16.
//  Copyright © 2016 Marcelo Reina. All rights reserved.
//

import UIKit

protocol ShoppingListPresenterView: class {
    func showItems(products: [Product])
}

class ShoppingListPresenter: NSObject {
    
    private weak var view: ShoppingListPresenterView! //should be weak to avoid retain cycle!
    private let dataStore: ProductDataStore
    
    init(view: ShoppingListPresenterView) {
        self.view = view
        self.dataStore = FilePersistentProductDataStore()
    }
    
    func loadShoppingList() {
        //load products from data store
        let products = loadProducts()
        //notify the view
        view.showItems(products: products)
    }
        
    func save(product: Product) {
        //update data store
        dataStore.saveProduct(product: product)
        
        //reload products from data store
        let products = loadProducts()
        
        //notify the view
        view.showItems(products: products)
    }
    
    private func loadProducts() -> [Product] {
        //load from data store or create an empty
        if let products = dataStore.retrieveProductList() {
            return products
        } else {
            return [Product]()
        }
    }
    
}
