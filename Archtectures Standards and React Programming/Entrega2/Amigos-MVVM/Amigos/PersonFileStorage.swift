//
//  PeopleStorage.swift
//  Amigos
//
//  Created by Marcelo Reina on 15/05/17.
//  Copyright © 2017 Marcelo Reina. All rights reserved.
//

import Foundation

class PersonFileStorage : PersonDataStore {
    
        
    //MARK: Constants
    static fileprivate let fileName = "people"
    static fileprivate let fileExtension = "JSON"
    
    
    //Cache on memory
    var people: [Person]?
    
    
    /// Load people.JSON file and parse the information to return a `Person` array.
    ///
    /// - Returns: Person array or nil if it was unable to load or parse.
    public func retrievePersonList() -> [Person]? {
        
        if people == nil {
            // Get file url from main bundle
            let url = Bundle.main.url(forResource: PersonFileStorage.fileName, withExtension: PersonFileStorage.fileExtension)
            guard url != nil else {
                return nil
            }
            
            // Load data from file url
            let data = try? Data(contentsOf: url!)
            guard data != nil else {
                return nil
            }
            
            // Convert Data to JSON
            let rawJson = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            guard rawJson != nil else {
                return nil
            }
            
            
            let json = rawJson as? [String: Any]
            guard json != nil else {
                return nil
            }
            
            self.people = PersonFileStorage.parsePeople(json: json!)
            // parse people
        }
        
        return people
    }
    
    
    //Delete a person from cache memory only
    public func deletePerson(person toFind: Person) {
        var index = 0
        if people != nil {
            for person in people! {
                if person == toFind {
                    people!.remove(at: index)
                    return
                }
                index += 1
            }
        }
    }
    
    //MARK: JSON parser functions
    class fileprivate func parsePeople(json: [String: Any]) -> [Person]? {
        
        let results = json["results"] as? [[String: Any]]
        guard results != nil else {
            return nil
        }
        
        var personArray = [Person]()
        for personJSON in results! {
    
            if let person = parsePerson(json: personJSON) {
                personArray.append(person)
            }
        }
        
        return personArray
    }
    
    
    class fileprivate func parsePerson(json: [String: Any]) -> Person? {
        
        let addressJSON = json["location"] as? [String: Any]
        guard addressJSON != nil else {
            return nil
        }
        
        let address = parseAddress(json: addressJSON!)
        guard address != nil else {
            return nil
        }
        
        let name = json["name"] as? [String: Any]
        guard name != nil else {
            return nil
        }
        
        let firstName = name!["first"] as? String
        guard firstName != nil else {
            return nil
        }
        
        let lastName = name!["last"] as? String
        guard lastName != nil else {
            return nil
        }
        
        let title = name!["title"] as? String
        guard title != nil else {
            return nil
        }
        
        let email = json["email"] as? String
        guard email != nil else {
            return nil
        }
        
        let phone = json["phone"] as? String
        guard phone != nil else {
            return nil
        }
        
        let cell = json["cell"] as? String
        guard cell != nil else {
            return nil
        }
        
        let picture = json["picture"] as? [String:Any]
        guard picture != nil else {
            return nil
        }
        
        let profilePictureString = picture!["large"] as? String
        guard profilePictureString != nil else {
            return nil
        }
        
        let profilePicture = URL(string: profilePictureString!)
        guard profilePicture != nil else {
            return nil
        }
        
        return Person(title: title!,
                      firstName: firstName!,
                      lastName: lastName!,
                      email: email!,
                      phone: phone!,
                      cell: cell!,
                      address: address!,
                      profilePicture: profilePicture!)
    }
    
    class fileprivate func parseAddress(json: [String: Any]) -> Address? {
        
        let street = json["street"] as? String
        guard street != nil else {
            return nil
        }
        
        let city = json["city"] as? String
        guard city != nil else {
            return nil
        }
        
        let state = json["state"] as? String
        guard state != nil else {
            return nil
        }
        
        let postCode = json["postcode"] as? Int64
        guard postCode != nil else {
            return nil
        }
        
        return Address(street: street!,
                       city: city!,
                       state: state!,
                       postCode: postCode!)
    }
    
}
