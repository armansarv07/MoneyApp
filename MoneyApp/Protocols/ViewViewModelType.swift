//
//  ViewViewModelType.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//

import Foundation

protocol ViewViewModelType {
    var selectedRow: IndexPath? { get }
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType?
    func selectedRow(atIndexPath indexPath: IndexPath)
}
