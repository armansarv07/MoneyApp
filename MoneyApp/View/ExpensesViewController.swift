//
//  IncomesViewController.swift
//  MoneyApp
//
//  Created by Arman on 30.12.2021.
//

import UIKit

class ExpensesViewController: UIViewController {
    let tableView = UITableView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public var viewModel: ExpenseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItems()
        setupContraints()
        viewModel = ExpenseViewModel()
        viewModel?.fetchData {
            self.tableView.reloadData()
        }
    }
    
    @objc private func addIncome() {
        showAlertController(title: "Add Expense", message: "Add your expense!", mode: .add)
    }
    
    @objc private func showBalance() {
        let ac = UIAlertController(title: "Balance", message: TotalBalanceCount().calculate(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(okAction)
        self.present(ac, animated: true, completion: nil)
    }
    
}


extension ExpensesViewController {
    func showAlertController(title: String, message: String, mode: AlertControllerMode , style: UIAlertController.Style = .alert, indexPath: IndexPath = IndexPath(index: 0)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addTextField { $0.placeholder = "Title"
            if mode == .update {
                $0.text = self.viewModel?.expenses![indexPath.row].title
            }
        }
        alertController.addTextField { $0.placeholder = "Category"
            if mode == .update {
                $0.text = self.viewModel?.expenses![indexPath.row].category
            }
        }
        alertController.addTextField { $0.placeholder = "Amount"; $0.keyboardType = .decimalPad
            if mode == .update {
                if let amount = self.viewModel?.expenses?[indexPath.row].amount {
                    $0.text = String(amount)
                }
                    
            }
        }
        
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak alertController] action in
            guard let textfields = alertController?.textFields else { return }
            
            
            if let title = textfields[0].text,
               let category = textfields[1].text,
               let amount = textfields[2].text {
                
                switch mode {
                case .add:
                    self.viewModel?.addData(title: title, category: category, amount: Int64(amount) ?? 0, tableViewHandler: {
                        self.tableView.reloadData()
                    })
                case .update:
                    self.viewModel?.updateData(atIndexPath: indexPath, newTitle: title, newCategory: category, newAmount: Int64(amount) ?? 0, tableViewHandler: {
                        self.tableView.reloadData()
                    })
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ExpensesViewController {
    private func setupNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Expense List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addIncome))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Total Balance", style: .done, target: self, action: #selector(showBalance))
    }
}

extension ExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(IncomeCellView.self, forCellReuseIdentifier: IncomeCellView.reuseId)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IncomeCellView.reuseId, for: indexPath) as? IncomeCellView
        guard let tableViewCell = cell,
              let viewModel = viewModel else { return UITableViewCell() }
        tableViewCell.viewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showAlertController(title: "Update", message: "Update expense value", mode: .update, style: .alert, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete Expense") { action, view, completionHandler in
            self.viewModel?.removeData(atIndexPath: indexPath, tableViewHandler: {
                self.tableView.reloadData()
            })
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


extension ExpensesViewController {
    private func setupContraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}


// MARK: Enable Canvas of SwiftUI
import SwiftUI

struct ExpensesVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let tabBarVC = MainTabBarController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            return tabBarVC
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
