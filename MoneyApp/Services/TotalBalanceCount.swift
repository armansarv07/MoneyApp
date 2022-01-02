//
//  TotalBalanceCount.swift
//  MoneyApp
//
//  Created by Arman on 01.01.2022.
//

import Foundation
import CoreData
import UIKit

class TotalBalanceCount {
    
    let incomes: [Income]?
    let expenses: [Expense]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        var copyExpenses: [Expense] = []
        var copyIncomes: [Income] = []
        do {
            let request = Income.fetchRequest() as NSFetchRequest<Income>
            copyIncomes = try context.fetch(request)
        } catch {
            
        }
        
        
        do {
            let request = Expense.fetchRequest() as NSFetchRequest<Expense>
            copyExpenses = try context.fetch(request)
        } catch {
            
        }
        
        self.incomes = copyIncomes
        self.expenses = copyExpenses
    }
    
    func calculate() -> String {
        var sumIncome = 0
        var sumExpense = 0
        for income in self.incomes ?? [] {
            sumIncome += Int(income.amount)
        }
        
        for expense in self.expenses ?? [] {
            sumExpense += Int(expense.amount)
        }
        return "Total balance is: \(sumIncome - sumExpense)"
    }
}
