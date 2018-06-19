//
//  PeopleServices.swift
//  Amigos
//
//  Created by Marcelo Reina on 15/05/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

//  Person DataStore protocol
//  This is a glue protocol to bind modelView to model
protocol PersonDataStore {
    func retrievePersonList() -> [Person]?
    func deletePerson(person toFind: Person)
}
