//
//  AddProductRouter.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

///This class is part of the "Router" layer on the VIPE**R** architecture.
///It is responsible for the UI navigation logic.
class AddProductRouter: NSObject {

    weak var viewController: AddProductViewController?
    
    ///Dismiss the add product interface back to the scene that
    ///fired this action.
    func dismissAddInterface() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
