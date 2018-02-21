//
//  ProductListViewController.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/27/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

//MARK: Interfaces
protocol ManageProductListViewControllerInput
{
    func presentProductList(viewModel: ManageProductList.ViewModel)
}

protocol ManageProductListViewControllerOutput
{
    func displayProductList(request: ManageProductList.Request)
    func changeProductSelection(product:ManageProductList.ViewModel.DisplayedProduct)
}

//MARK: Implementation

///This class is part of the "View" layer on the **V**IPER architecture.
///It is responsible for capture the users' interaction and passively present
///data back to them.
class ManageProductListViewController: UIViewController {
    
    @IBOutlet var productList: UITableView!
    
    ///This variable connects the View Controller to
    ///the technology-independent UI logic. It is associated
    ///to an interface in order to keep it loose coupled to
    ///other pieces of code. This interface will be implemented,
    ///usually, by a Presenter class.
    var output: ManageProductListViewControllerOutput?
    
    ///The router controls the navigation from this View Controller
    ///to associated ones
    var router: ManageProductListRouter?
    
    ///Product list, using a UI-oriented data representation
    var displayedProductList: [ManageProductList.ViewModel.DisplayedProduct] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Configure the VIPER structure for this scene
        let configurator = ManageProductListConfigurator()
        configurator.configure(viewController: self)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Fetch the product shopping list
    func fetchProducts()
    {
        let request = ManageProductList.Request.ProductList()
        
        //Send
        output?.displayProductList(request: request)
    }
    


}


extension ManageProductListViewController: ManageProductListViewControllerInput {
    
    
    func presentProductList(viewModel: ManageProductList.ViewModel) {
        
        if let products = viewModel.productList {
            
            displayedProductList = products
        
            
            productList.reloadData()
            
        }
        
    }
    
}


//This extension conforms to the UITableViewDataSource. It is
//responsible for presenting the product list back to the user
extension ManageProductListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
        
        let product = displayedProductList[indexPath.row]
        
        cell?.textLabel?.text = product.name
        
        if (product.checked) {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell!
        
    }
    
    
}

//This extension conforms to the UITableViewDelegate. This is
//used, on this particular example, to capture the product 
//mark/unmark
extension ManageProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //get product
        let selectedProduct = displayedProductList[indexPath.row]
        
        output?.changeProductSelection(product: selectedProduct)
        
    }
    
    
}
