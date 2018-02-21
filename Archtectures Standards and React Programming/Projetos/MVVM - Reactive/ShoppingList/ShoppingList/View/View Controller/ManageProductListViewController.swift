//
//  ManageProductListViewController.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 14/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


/// Screen that manages the product list and its checking/unchecking
class ManageProductListViewController: UITableViewController {
    
    //MARK: - Outlets
    
    @IBOutlet var addProductButton: UIBarButtonItem!
    
    //MARK: - Properties
    
    /// View Model associated with this screen
    var viewModel:ManageProductListViewModel? {
        didSet {
            bindToViewModel()
        }
    }
    
    /// Reactive cleaning bag
    var bag = DisposeBag()


    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = nil
        tableView.dataSource = nil
        
        viewModel = ManageProductListViewModel()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Bindings
    
    private func bindToViewModel() {
        
        if let viewModel = self.viewModel {
            
            //Binds product list to table presentation
            viewModel.productList
                .bind(to: tableView.rx.items(cellIdentifier: "myCell")){ (row, product, cell) in
                    cell.textLabel?.text = product.name
                    cell.accessoryType = product.checked ? .checkmark : .none
                }
                .disposed(by: bag)
            
            // Bind add button to product change event listener
            addProductButton.rx.tap.map { event -> Product? in
                return nil
                }
                .bind(to: viewModel.productChange)
                .disposed(by: bag)
            
            // Map the selected product to product selection listener (ViewModel)
            tableView.rx.modelSelected(Product.self)
                .map { event -> Product in
                    event
                }
                .bind(to: viewModel.productSelected)
                .disposed(by: bag)
            
            //Add product was fired, redirects to proper screen
            viewModel.addProduct
                .subscribe(onNext: { _ in
                    self.performSegue(withIdentifier: "editProductSegue", sender: self)
                })
                .disposed(by: bag)
            
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    /// Unwind segue destination
    ///
    /// - Parameter segue: segue that perfomed the unwind
    @IBAction func rewindToList(segue:UIStoryboardSegue) {
        
    }
    
    

}
