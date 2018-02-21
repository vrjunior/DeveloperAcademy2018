//
//  AddProductViewController.swift
//  ShoppingListMVC
//
//  Created by Marcelo Reina on 28/07/16.
//  Copyright © 2016 Marcelo Reina. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var productNameField: UITextField!
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        productNameField.becomeFirstResponder()
    }

    //MARK: - Actions
    @IBAction func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction() {
        
        guard !productNameField.text!.isEmpty else {
            showErrorAlert(message: "Product must have a name!")
            return
        }
        
        //create new product
        let product = Product(name: productNameField.text!, checked: false)
        
        //check if the product is not in the list
        let dataStore = FilePersistentProductDataStore()
        if let productList = dataStore.retrieveProductList() {
            
            //filter list to find if the product is already in the list
            let sameProducts = productList.filter { (currentProduct) -> Bool in
                return currentProduct == product
            }
            
            guard sameProducts.count == 0 else {
                showErrorAlert(message: "\(product.name) is already in the list!")
                return
            }
        }
        
        //save product and dismiss view controller
        dataStore.saveProduct(product: product)
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Error Alerts
    private func showErrorAlert(message: String) {
        let errorAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
