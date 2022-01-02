//
//  CellProtocol.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//

import Foundation


protocol CellViewModelType {
    var title: String { get }
    var category: String { get }
    var amount: String { get }
}
