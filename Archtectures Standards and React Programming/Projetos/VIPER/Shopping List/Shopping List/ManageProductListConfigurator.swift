//
//  ProductListConfigurator.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/27/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

//MARK: Adapters

// This methods connectes interfaces from each layer to the adjacent ones.
// In this project, as the equivalent provided and required interfaces are the same
// (same functions and signatures) no adaptation is needed. In case there are
// discrepancies here function that "translates" data from one interface to another could
// be implemented (Adapter design pattern)

extension ManageProductListViewController: ManageProductListPresenterUserInterfaceOutput {
    
}

extension ManageProductListPresenter: ManageProductListViewControllerOutput {
    
}

extension ManageProductListPresenter: ManageProductListInteractorOutput {
    
}

extension ManageProductListInteractor: ManageProductListPresenterBusinessInput {
    
}

//This extension wires the view controller segue preparation to
//the router, allowing it to control the navigation
extension ManageProductListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        router?.passDataToNextScene(segue: segue)
    }
}

//MARK: Public Methods

///This class creates and configures the relation between all layers
///on the VIPER architecture.
class ManageProductListConfigurator: NSObject {

    func configure(viewController: ManageProductListViewController) {
        
        let presenter = ManageProductListPresenter()
        let interactor = ManageProductListInteractor()
        let router = ManageProductListRouter()
        
        viewController.output = presenter
        viewController.router = router
        
        presenter.userInterface = viewController
        presenter.businessInterface = interactor
        
        interactor.output = presenter
        interactor.productStore = FilePersistentProductDataStore()
        
            
    }
    
}
