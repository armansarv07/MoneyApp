//
//  IncomeViewModel.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//

import Foundation
import UIKit
import CoreData

class IncomeViewModel: ViewViewModelType, CoreDataCRUDProtocol {
    
    
    
    var incomes: [Income]?
    
    var selectedRow: IndexPath?
    
    func numberOfRows() -> Int {
        return incomes?.count ?? 0
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType? {
        guard let income = incomes?[indexPath.row] else { return nil }
        return CellViewModel(operaton: income)
    }
    
    func selectedRow(atIndexPath indexPath: IndexPath) {
        selectedRow = indexPath
    }
    
    // MARK: CoreData CRUD Operartions
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchData(tableViewHandler handler: @escaping () -> ()) {
        do {
            let request = Income.fetchRequest() as NSFetchRequest<Income>
            self.incomes = try context.fetch(request)
            DispatchQueue.main.async {
                handler()
            }
        } catch {
            
        }
    }
    
    func addData(title: String, category: String, amount: Int64, tableViewHandler handler: @escaping () -> ()) {
        let income = Income(context: context)
        income.title = title
        income.category = category
        income.amount = amount
        
        do {
            try context.save()
        } catch {
            
        }
        
        fetchData {
            handler()
        }
    }
    
    func updateData(atIndexPath indexPath: IndexPath, newTitle title: String, newCategory category: String, newAmount amount: Int64, tableViewHandler handler: @escaping () -> ()) {
        let income = self.incomes![indexPath.row]
        
        income.title = title
        income.category = category
        income.amount = amount
        
        do {
            try context.save()
        } catch {
            
        }
        fetchData {
            handler()
        }
    }
    
    func removeData(atIndexPath indexPath: IndexPath, tableViewHandler handler: @escaping () -> ()) {
        let incomeToRemove = incomes![indexPath.row]
        
        self.context.delete(incomeToRemove)
        do {
            try context.save()
        } catch {
            
        }
        fetchData {
            handler()
        }
    }
    
}
