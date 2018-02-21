//
//  AddProductInterface.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import Foundation

protocol AddProductInterface {
    
    func cancelAddAction()
    func saveAddActionWithName(_ name: NSString)
    
}
