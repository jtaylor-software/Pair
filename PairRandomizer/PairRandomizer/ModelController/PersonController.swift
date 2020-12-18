//
//  PersonController.swift
//  PairRandomizer
//
//  Created by Jeremy Taylor on 12/18/20.
//

import Foundation
import CoreData

class PersonController {
    // MARK: - Properties
    
    static let sharedInstance = PersonController()
    var people: [Person] {
            let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
            return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        }
    
    // MARK: - CRUD Methods
    
    func addPerson(name: String) {
     _ = Person(name: name)
        saveToPersistantStore()
    }
    
    func deletePerson(person: Person) {
        CoreDataStack.context.delete(person)
        saveToPersistantStore()
    }
    
    func saveToPersistantStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
} //End of class
