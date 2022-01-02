//
//  CellViewModel.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//

import Foundation
import CoreData

class CellViewModel<T: ModelProtocol>: CellViewModelType {
    private let operation: T
    
    var title: String {
        guard let newTitle = operation.title else { return "Unknown"}
        return "Title: " + newTitle
    }
    
    var category: String {
        guard let newCategory = operation.category else { return "Unknown"}
        return "Category: " + newCategory
    }
    
    var amount: String {
        return "Amount: \(operation.amount)"
    }
    
    init(operaton: T) {
        self.operation = operaton
    }
}
