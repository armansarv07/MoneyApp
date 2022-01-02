//
//  Income+CoreDataProperties.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//
//

import Foundation
import CoreData


extension Income {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Income> {
        return NSFetchRequest<Income>(entityName: "Income")
    }

    @NSManaged public var amount: Int64
    @NSManaged public var category: String?
    @NSManaged public var title: String?

}

extension Income : Identifiable {

}
