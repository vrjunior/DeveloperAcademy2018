//
//  ManagerPerson.swift
//  Amigos
//
//  Created by Valmir Junior on 21/02/18.
//  Copyright © 2018 Marcelo Reina. All rights reserved.
//

import Foundation
import RxSwift

protocol ManagePerson {
    
    var deletePerson : PublishSubject<Person> { get }
    
    func delete(person: Person)
    
}
