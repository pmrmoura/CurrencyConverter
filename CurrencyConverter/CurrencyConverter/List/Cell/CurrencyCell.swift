//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 11/05/21.
//

import UIKit

final class CurrencyCell: UITableViewCell, ViewCode {
    
    let horizontalStackView: UIStackView = UIStackView()
    let countryFlag: UILabel = UILabel()
    let countryCode: UILabel = UILabel()
    let countryName: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubViews() {
        self.addSubview(horizontalStackView)
        self.horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [countryFlag, countryName, countryCode]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                self.horizontalStackView.addArrangedSubview($0)
            }
    }

    func setupContraints() {
        NSLayoutConstraint.activate([
            self.horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

        ])
    }

    func setupAdditionalConfiguration() {
        self.selectionStyle = .none
        
        self.horizontalStackView.axis = .horizontal
        self.horizontalStackView.alignment = .fill
        self.horizontalStackView.distribution = .fillEqually
    }
}
