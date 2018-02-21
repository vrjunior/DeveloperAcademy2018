//
//  PersonModel.swift
//  Amigos
//
//  Created by Valmir Junior on 21/02/18.
//  Copyright © 2018 Marcelo Reina. All rights reserved.
//

import Foundation
import RxSwift

struct PersonModel {
    
    static let shared = PersonModel()
    
    public let personPublisher = PublishSubject<[Person]>()
    public let deletePublisher = PublishSubject<Person>()
    
    public var dataStore: PersonDataStore = PersonFileStorage()
    
}

extension PersonModel : PersonList {
    
    public var people: PublishSubject<[Person]> {
        get {
            return personPublisher
        }
    }
    
    func personList() {
        if let people = self.dataStore.retrievePersonList() {
            personPublisher.onNext(people)
        }
    }
}

extension PersonModel : ManagePerson {
    
    var deletePerson: PublishSubject<Person> {
        get {
            return deletePublisher
        }
    }
    
    func delete(person: Person) {
        dataStore.deletePerson(person: person)
        deletePublisher.onNext(person)
    }
    
}

