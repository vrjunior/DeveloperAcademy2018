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

class MyFriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
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
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        refresh.addTarget(self, action: #selector(MyFriendsViewController.refreshAction), for: .valueChanged)
//        tableView.addSubview(refresh)
//
//        personServices = PersonServices(delegate: self)
//        personServices.getPeople(ordered: true)
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

//extension MyFriendsViewController: PersonServicesDelegate {
//    func didReceivedPeople(people: [Person]) {
//        refresh.endRefreshing()
//        listOfPeople = people
//        tableView.reloadData()
//    }
//
//    func failedToGetPeople() {
//        refresh.endRefreshing()
//        print("error")
//    }
//}
//
//extension MyFriendsViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var numberOfRows = 0
//
//        if let people = listOfPeople {
//            numberOfRows = people.count
//        }
//
//        return numberOfRows
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
//
//        let person = listOfPeople![indexPath.row]
//        cell.name.text = "\(person.firstName.capitalized) \(person.lastName.capitalized)"
//        cell.email.text = person.email
//        cell.cell.text = person.cell
//
//        cell.profilePicture.image = nil
//        cell.profilePicture.alpha = 0
//        cell.isSelected = false
//        ImageCache.shared.getImage(from: person.profilePicture) { (image) in
//            if let image = image {
//                cell.profilePicture?.image = image
//                UIView.animate(withDuration: 0.3, animations: {
//                    cell.profilePicture.alpha = 1
//                })
//            }
//        }
//
//        return cell
//    }
//}

//extension MyFriendsViewController: UITableViewDelegate {
//
//    //MARK: Display management
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//    }
//
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let personCell = cell as? PersonTableViewCell {
//            personCell.imageView?.image = nil
//        }
//
//        if listOfPeople != nil && indexPath.row < listOfPeople!.count {
//            let person = listOfPeople![indexPath.row]
//            ImageCache.shared.cancelImageDownload(from: person.profilePicture)
//        }
//    }
//
//    //MARK: Selection
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "PersonDetailViewController", sender: nil)
//    }
//
//    //MARK: Replace management
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
//        return proposedDestinationIndexPath
//    }
//
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let from = listOfPeople![sourceIndexPath.row]
//        let to = listOfPeople![destinationIndexPath.row]
//        listOfPeople![destinationIndexPath.row] = from
//        listOfPeople![sourceIndexPath.row] = to
//    }
//
//    //MARK: Edit actions (remove)
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "Eliminar"
//    }
//
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
//        return .delete
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            listOfPeople?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//
//    //MARK: Actions iOS 8
//    /*func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let sendMail = UITableViewRowAction(style: .normal, title: "Enviar email") { (action, indexPath) in
//            if let cell = tableView.cellForRow(at: indexPath) {
//                cell.alpha = 0
//                UIView.animate(withDuration: 0.3, animations: {
//                    cell.alpha = 1.0
//                })
//            }
//        }
//        sendMail.backgroundColor = .blue
//
//        let call = UITableViewRowAction(style: .normal, title: "Chamar") { (action, indexPath) in
//            if let cell = tableView.cellForRow(at: indexPath) {
//                cell.alpha = 0.5
//                UIView.animate(withDuration: 0.3, animations: {
//                    cell.alpha = 1.0
//                })
//            }
//        }
//        call.backgroundColor = .purple
//
//        return [sendMail, call]
//    }*/
//}

