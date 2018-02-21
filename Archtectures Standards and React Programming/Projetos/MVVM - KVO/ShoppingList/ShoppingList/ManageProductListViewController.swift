//
//  ManageProductListViewController.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 7/29/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

///This class represents the manage product list view on a M**V**VM architecture.
@objc
class ManageProductListViewController: UIViewController {
    
    private var myContext = 0

    @IBOutlet var productList: UITableView!
    
    ///Reference to the view model
    var viewModel: ManageProductListViewModel? {
        didSet {
            //Set KVOs to be notified when the view model changes.
            //In this particular case it just observers the listLoaded attribute
            //hat indiciates whether the product list has changed
            listLoadedObserver = viewModel?.observe(\.listLoaded, options:[.new]) { [weak self] (changedViewModel, listLoaded) in
                if let listLoaded = listLoaded.newValue  {
                    if listLoaded {
                        //If the list is loaded it indicates that the interface
                        //must be refreshed.
                        self?.refreshProductList()
                    }
                }
            }
            
            
            //Reload the list as model probably has changed
            reloadProductList()
        }
    }
    
    var listLoadedObserver: NSKeyValueObservation?
    
    //MARK: View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = ManageProductListViewModel()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         reloadProductList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Interface related methods
    func reloadProductList() {
        viewModel?.displayProductList()
    }
    
    func refreshProductList() {
        productList.reloadData()
    }
    
    @IBAction func addProduct(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "CreateProduct", sender: self)
        
    }
    

    
    /*
    //MARK: KVO listener function
    override func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [NSKeyValueChangeKey : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
        
        if let path = keyPath {
            if context == &myContext {
                switch path {
                    case "listLoaded":
                        let result = change?[NSKeyValueChangeKey.newKey] as? Bool
                        if let listLoaded = result {
                            if listLoaded {
                                //If the list is loaded it indicates that the interface
                                //must be refreshed.
                                refreshProductList()
                            }
                        }
                    default:
                        break
                }
            }
        }
    }
    */

}

//This extension represents the table view data related methods
extension ManageProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let numberOfProducts = viewModel?.numberOfProducts {
            return numberOfProducts
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
        
        let item = viewModel?.items?[indexPath.row]
        
        if let presentedItem = item {
            cell?.textLabel?.text = presentedItem.name
            
            if (presentedItem.checked) {
                cell?.accessoryType = .checkmark
            } else {
                cell?.accessoryType = .none
            }
        }
        
        return cell!
    }
    
}


//This extension implements the table view delegate methods, in this case just
//to get the item selection
extension ManageProductListViewController:UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       viewModel?.changeProductStatus(index: indexPath.row)
    }
    
}



