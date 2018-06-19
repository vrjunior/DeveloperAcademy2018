//
//  PersonList.swift
//  Amigos
//
//  Created by Valmir Junior on 21/02/18.
//  Copyright © 2018 Marcelo Reina. All rights reserved.
//

import Foundation
import RxSwift

protocol PersonList {
    
    var people: PublishSubject<[Person]> { get }
    func personList()
    
}
