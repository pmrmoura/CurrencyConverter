//
//  ConvertView.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import UIKit

final class ConvertView: UIView, ViewCode {
    
    lazy var currencyList = UIButton()
    lazy var hStack = UIStackView()
    lazy var originCurrency = SelectCountryView()
    lazy var destinationCurrency = SelectCountryView()
    lazy var desinationCurrencyArrow = UIImageView()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        [currencyList, hStack]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        [originCurrency, desinationCurrencyArrow, destinationCurrency]
            .forEach {
                hStack.addArrangedSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            self.currencyList.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            self.currencyList.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
            self.currencyList.widthAnchor.constraint(equalToConstant: 100),
            self.currencyList.heightAnchor.constraint(equalToConstant: 100),
            
            self.hStack.topAnchor.constraint(equalTo: self.currencyList.bottomAnchor, constant: 30),
            self.hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.hStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        
        let currencyListButtonConfiguration = UIImage.SymbolConfiguration(pointSize: 35, weight: .thin)
        let currencyListButtonImage = UIImage(systemName: "globe", withConfiguration: currencyListButtonConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.currencyList.setImage(currencyListButtonImage, for: UIControl.State())
        
        let destinationArrowConfiguration = UIImage.SymbolConfiguration(pointSize: 35, weight: .semibold)
        let destinationArrowImage = UIImage(systemName: "arrow.right", withConfiguration: destinationArrowConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.desinationCurrencyArrow.image = destinationArrowImage
        
        hStack.axis = .horizontal
        hStack.alignment = .fill
        hStack.distribution = .equalSpacing
    }
}
