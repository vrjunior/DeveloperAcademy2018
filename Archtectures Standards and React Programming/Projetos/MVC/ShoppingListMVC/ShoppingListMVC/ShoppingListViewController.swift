//
//  ViewController.swift
//  ShoppingListMVC
//
//  Created by Marcelo Reina on 27/07/16.
//  Copyright © 2016 Marcelo Reina. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    fileprivate let CELL_IDENTIFIER = "ProductCell"
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var productList = [Product]()
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProductList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadProductList()
    }
    
    //MARK: - Product List Management
    fileprivate func loadProductList() {
        productList.removeAll()
        
        //get products from store
        let dataStore = FilePersistentProductDataStore()
        if let list = dataStore.retrieveProductList() {
            productList.append(contentsOf: list)
        }
        
        //reload view
        tableView.reloadData()
    }
}

//MARK: - Table view data source
extension ShoppingListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER)
        
        let product = productList[indexPath.row]
        cell!.textLabel!.text = product.name
        cell!.accessoryType = product.checked ? .checkmark : .none
        
        return cell!
    }
}

//MARK: - Table view delegate
extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        
        //create product with new checked value
        let updatedProduct = Product(name: product.name, checked: !product.checked)
        
        //save to data store
        let dataStore = FilePersistentProductDataStore()
        dataStore.saveProduct(product: updatedProduct)
        
        //reload product list
        loadProductList()
    }
}


