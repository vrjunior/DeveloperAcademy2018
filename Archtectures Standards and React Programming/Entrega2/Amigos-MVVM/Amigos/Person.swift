//
//  Person.swift
//  Amigos
//
//  Created by Marcelo Reina on 15/05/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

struct Person {
    let title: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let cell: String
    let address: Address
    let profilePicture: URL
}

extension Person : Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        if lhs.firstName == rhs.firstName && lhs.phone == rhs.phone {
            return true
        }
        return false
    }
    

}
