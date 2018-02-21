//
//  PeopleServices.swift
//  Amigos
//
//  Created by Marcelo Reina on 15/05/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import UIKit

/// Responsibilities for the one who uses `PersonServices`
protocol PersonDataStore {
    func retrievePersonList() -> [Person]?
    func deletePerson(person toFind: Person)
}



/// Person provider.
/// It performs asynchronous tasks and requires a delegate to manage received data
class PersonServices: NSObject {
    
    //MARK: Initialization
    fileprivate override init() {}
        
    
    /// Get people asynchronously and calls the delegate when it receives the list of people
    ///
    /// - Parameter ordered: if the list of person should be ordered by names.
//    func getPeople(ordered: Bool) {
//        delayedGetPeople(ordered: true, delayInSeconds: 4.0)
//    }
    

//    fileprivate func delayedGetPeople(ordered: Bool, delayInSeconds: TimeInterval) {
//        Timer.scheduledTimer(withTimeInterval: delayInSeconds, repeats: false) { (timer) in
//            if var listOfPeople = PersonFileStorage.loadPeopleFromFile() {
//                if ordered {
//                    listOfPeople = listOfPeople.sorted(by: { (oneElement, otherElement) -> Bool in
//                        return oneElement.firstName.compare(otherElement.firstName) == .orderedAscending
//                    })
//                }
//                self.delegate.didReceivedPeople(people: listOfPeople)
//            } else {
//                self.delegate.failedToGetPeople()
//            }
//            timer.invalidate()
//        }
//    }

}
