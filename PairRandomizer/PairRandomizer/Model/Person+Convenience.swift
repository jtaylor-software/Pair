//
//  Person+Convenience.swift
//  PairRandomizer
//
//  Created by Jeremy Taylor on 12/18/20.
//

import Foundation
import CoreData

extension Person {
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
