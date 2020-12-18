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
    var people: [Person] = []
    
    var pairs: [[Person]] {
        return randomPairs(peopleArray: people)
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
    
    func fetchPeople() {
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            people = try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func randomPairs(peopleArray: [Person])  -> [[Person]] {
        let splitSize = 2
        let peopleSections = stride(from: 0, to: peopleArray.count, by: splitSize).map { Array(peopleArray[$0..<min($0 + splitSize, peopleArray.count)]) }
        return peopleSections
    }
    
    func randomize() {
        people.random()
        saveToPersistantStore()
    }
    
} //End of class
