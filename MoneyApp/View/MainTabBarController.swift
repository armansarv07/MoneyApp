//
//  ViewController.swift
//  MoneyApp
//
//  Created by Arman on 30.12.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            generateNavigationController(rootViewController: ExpensesViewController(), title: "Expenses", image: UIImage(systemName: "cart.fill")!),
            generateNavigationController(rootViewController: IncomesViewController(), title: "Incomes", image: UIImage(systemName: "dollarsign.circle.fill")!)
            
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}

