//
//  CoreDataCRUDProtocol.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//

import CoreData

protocol CoreDataCRUDProtocol {
    func fetchData(tableViewHandler handler: @escaping () -> ())
    func addData(title: String, category: String, amount: Int64, tableViewHandler handler: @escaping () -> ())
    func removeData(atIndexPath indexPath: IndexPath, tableViewHandler handler: @escaping () -> ())
    func updateData(atIndexPath indexPath: IndexPath, newTitle title: String, newCategory category: String, newAmount amount: Int64, tableViewHandler handler: @escaping () -> ())
}
