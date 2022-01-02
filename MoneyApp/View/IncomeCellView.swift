//
//  IncomeCell.swift
//  MoneyApp
//
//  Created by Arman on 31.12.2021.
//

import UIKit

class IncomeCellView: UITableViewCell {
    static var reuseId = "IncomeCell"
    let titleLable = UILabel(text: "", font: .laoSangamMN18())
    let categoryLable = UILabel(text: "", font: .laoSangamMN18())
    let amountLabel = UILabel(text: "", font: .laoSangamMN18())
    
    var viewModel: CellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLable.text = viewModel.title
            categoryLable.text = viewModel.category
            amountLabel.text = viewModel.amount
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [titleLable, categoryLable, amountLabel], axis: .vertical, spacing: 8)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
        
    }
}
