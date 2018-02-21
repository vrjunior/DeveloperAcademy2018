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
    private var presenter: AddProductPresenter!
    
    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = AddProductPresenter(view: self)
        productNameField.becomeFirstResponder()
    }

    //MARK: - Actions
    @IBAction func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction() {
        presenter.saveProductAction(name: productNameField.text!)
    }
}

extension AddProductViewController: AddProductPresenterView {
    
    func didCreateProduct() {
        dismiss(animated: true, completion: nil)
    }
    
    func didFailCreatingProduct(errorMessage: String) {
        let errorAlert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        errorAlert.addAction(dismissAction)
        present(errorAlert, animated: true, completion: nil)
    }
}
