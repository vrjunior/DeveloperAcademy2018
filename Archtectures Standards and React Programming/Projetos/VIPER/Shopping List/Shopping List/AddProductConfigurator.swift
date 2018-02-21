//
//  AddProductConfigurator.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

//MARK: Adapters

// This methods connectes interfaces from each layer to the adjacent ones.
// In this project, as the equivalent provided and required interfaces are the same
// (same functions and signatures) no adaptation is needed. In case there are
// discrepancies here function that "translates" data from one interface to another
// could be implemented (Adapter design pattern)
extension AddProductViewController: AddProductPresenterUserInterfaceOutput {
    
}

extension AddProductPresenter: AddProductViewControllerOutput {
    
}

extension AddProductPresenter: AddProductInteractorOutput {
    
}

extension AddProductInteractor: AddProductPresenterBusinessOutput {
    
}

//MARK: Public Methods

///This class creates and configures the relation between all layers
///on the VIPER architecture.
class AddProductConfigurator: NSObject {
    
    func configure(viewController: AddProductViewController) {
        
        let presenter = AddProductPresenter()
        let interactor = AddProductInteractor()
        let router = AddProductRouter()
        
        viewController.output = presenter
        
        presenter.userInterface = viewController
        presenter.businessInterface = interactor
        presenter.router = router
        
        router.viewController = viewController
        
        interactor.output = presenter
        interactor.productStore = FilePersistentProductDataStore()
        
    }

}
