//
//  AddProductViewController.swift
//  ShoppingList
//
//  Created by SERGIO J RAFAEL ORDINE on 15/02/18.
//  Copyright © 2018 BEPiD. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa



/// Screen that manages the product inclusion
class AddProductViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet var btnSave: UIBarButtonItem!
    @IBOutlet var productName: UITextField!
    
    
    //MARK: - Properties
    
    var bag = DisposeBag()
    
    var viewModel:AddProductViewModel? {
        didSet {
            bindToViewModel()
        }
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel = AddProductViewModel()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Bindings
    
    private func bindToViewModel() {
        
        if let  viewModel = self.viewModel {
            
            btnSave.rx.tap
                .map { event -> Void in }
                .bind(to: viewModel.addProductAction).disposed(by: bag)
            
            productName.rx.text
                .map { event -> String? in event}
                .bind(to: viewModel.productName)
                .disposed(by:bag)
            
            viewModel.productAdded.subscribe(onNext:{ [weak self] (product) in
                self?.performSegue(withIdentifier: "backToListSegue", sender: self)
            }).disposed(by: bag)
            
        }
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
