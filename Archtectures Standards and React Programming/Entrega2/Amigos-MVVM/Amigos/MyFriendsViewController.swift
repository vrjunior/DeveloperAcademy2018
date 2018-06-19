//
//  ViewController.swift
//  Amigos
//
//  Created by Marcelo Reina on 15/05/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
//import RxDataSources

class MyFriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    //bag for prevent retain cycle
    var bag = DisposeBag()
    
    var viewModel: MyFriendsViewModel? {
        didSet {
            self.bindToViewModel()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        tableView.delegate = nil
        
        self.viewModel = MyFriendsViewModel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        ImageCache.shared.clear()
    }
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        if tableView.isEditing {
            editButton.title = "ok"
        } else {
            editButton.title = "editar"
        }
    }
    

    private func bindToViewModel() {
        if let viewModel = self.viewModel {
            
            viewModel.personList.bind(to:
                tableView.rx.items(cellIdentifier: "PersonTableViewCell")) { (row, person, cell) in
                    if let cell  = cell as? PersonTableViewCell {
                        
                        cell.name.text = "\(person.firstName.capitalized) \(person.lastName.capitalized)"
                        cell.email.text = person.email
                        cell.cell.text = person.cell
                
                        cell.profilePicture.image = nil
                        cell.profilePicture.alpha = 0
                        cell.isSelected = false
                        ImageCache.shared.getImage(from: person.profilePicture) { (image) in
                            if let image = image {
                                cell.profilePicture?.image = image
                                UIView.animate(withDuration: 0.3, animations: {
                                    cell.profilePicture.alpha = 1
                                })
                            }
                        }
                    }
            }
            .disposed(by: bag)
            
            tableView.rx.modelDeleted(Person.self)
            .map({ event -> Person in
                event
            })
            .bind(to: viewModel.deletePerson)
            .disposed(by: bag)
            
        }
    }
    
}

