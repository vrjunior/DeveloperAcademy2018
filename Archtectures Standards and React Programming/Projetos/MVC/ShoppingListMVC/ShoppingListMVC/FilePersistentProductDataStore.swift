//
//  FilePersistentDataStore.swift
//  Shopping List
//
//  Created by SERGIO J RAFAEL ORDINE on 7/26/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

class FilePersistentProductDataStore: NSObject, ProductDataStore {
    
    let FILE_NAME = "PRODUCT_LIST"
    
    
    func saveProduct(product:Product) {
        
        let path = storeFilePath()
        
        //Retrieve product list
        var productList = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [FilePersistentProduct]
        
        if (productList == nil) {
            productList = [FilePersistentProduct]()
        }
        
        //Convert product to persitent version
        let convertedProduct = FilePersistentProduct(product: product)
        
        //Check if prodouct is already at list
        let index = productList?.index(where: { (element) -> Bool in
            element.name == convertedProduct.name
        })
        
        //Include or update item
        if (index != nil) {
            productList?[index!] = convertedProduct
        } else {
            productList?.append(convertedProduct)
        }
        
        //Save list
        let result = NSKeyedArchiver.archiveRootObject(productList!, toFile: path)
    
        //handle error
        if (!result) {
            print("An error occurred while saving the product")
        }
        
    }
    
    func retrieveProductList() -> [Product]? {
        
        let path = storeFilePath()
        
        let persistentProductList = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [FilePersistentProduct]
        
        if let productList = persistentProductList {
            
            return productList.map({ (persistentProduct) -> Product in
                return Product(name: persistentProduct.name, checked: persistentProduct.checked)
            })
            
        } else {
            
            return nil
            
        }
        
    }
    
    
    private func storeFilePath() -> String {
        
        let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        // Get document directory from that list
        let documentDirectory = documentDirectories[0] as String
        
        // append with the .archive file name
        let path = documentDirectory.appending(FILE_NAME)
        
        
        return path
    }
    
 
}
