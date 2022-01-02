//
//  ModelProtocol.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//

import Foundation

protocol ModelProtocol {
    var amount: Int64 { get }
    var category: String? { get }
    var title: String? { get }
    
}
