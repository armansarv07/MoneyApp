//
//  Expense+CoreDataProperties.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var category: String?
    @NSManaged public var title: String?

}

extension Expense : Identifiable {

}
