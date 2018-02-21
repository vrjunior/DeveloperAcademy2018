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
    fileprivate var presenter: ShoppingListPresenter!
    fileprivate var productList: [Product]!
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ShoppingListPresenter(view: self)
        presenter.loadShoppingList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loadShoppingList()
    }
}

//MARK: - Shopping List Presenter View
extension ShoppingListViewController: ShoppingListPresenterView {
    
    func showItems(products: [Product]) {
        productList = products
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
        let updatedProduct = Product(name: product.name, checked: !product.checked)
        presenter.save(product: updatedProduct)
    }
}


