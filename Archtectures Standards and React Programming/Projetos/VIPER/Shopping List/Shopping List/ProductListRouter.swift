//
//  ProductListRouter.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/27/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

///This class is part of the "Router" layer on the VIPE**R** architecture.
///It is responsible for the UI navigation logic.
class ManageProductListRouter: NSObject {

    func passDataToNextScene(segue: UIStoryboardSegue)
    {
        // NOTE: Teach the router which scenes it can communicate with
        
        if segue.identifier == "CreateProduct" {
            //Pass data to destination view controller, in case it is needed
        }
    }

}
