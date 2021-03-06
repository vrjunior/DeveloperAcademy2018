//
//  MyFriendsViewModel.swift
//  Amigos
//
//  Created by Valmir Junior on 21/02/18.
//  Copyright © 2018 Marcelo Reina. All rights reserved.
//

import Foundation
import RxSwift

class MyFriendsViewModel {
    
    //Bag to prevent retain cycle
    private var bag = DisposeBag()
    
    //UI output streams
    let personList = BehaviorSubject<[Person]>(value: [])
    
    //UI input
    let deletePerson = PublishSubject<Person>()
    
    //Model
    let listModel: PersonList?
    let managerPerson: ManagePerson?
    
    init() {
        listModel = PersonModel.shared
        managerPerson = PersonModel.shared
        
        self.bindUIInputs()
        self.bindUIOutputs()
        
        self.listModel?.personList()
    }
    
    //Bind all outputs to channels
    func bindUIOutputs() {
        listModel?.people
            .bind(to: personList)
            .disposed(by: bag)

    }
    
    //Bind all inputs to channels
    func bindUIInputs() {
        deletePerson.subscribe(onNext: { (person) in
            print("hu3")
            self.managerPerson?.delete(person: person)
            self.listModel?.personList()
        })
        .disposed(by: bag)
    }
    
}
