//
//  CoreDataStack.swift
//  PairRandomizer
//
//  Created by Jeremy Taylor on 12/18/20.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PairRandomizer")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print(error)
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
