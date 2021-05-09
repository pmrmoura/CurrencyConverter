//
//  ConvertView.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import UIKit

final class ConvertView: UIView, ViewCode {
    
    lazy var mainVStack = UIStackView()
    lazy var currencyListHStack = UIStackView()
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
        self.addSubview(mainVStack)
        self.mainVStack.translatesAutoresizingMaskIntoConstraints = false
        
        [currencyListHStack, hStack]
            .forEach {
                mainVStack.addArrangedSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        [currencyList]
            .forEach {
                currencyListHStack.addArrangedSubview($0)
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
            self.mainVStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.mainVStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.mainVStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 40)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        
        self.mainVStack.axis = .vertical
        self.mainVStack.alignment = .fill
        self.mainVStack.distribution = .fillEqually
        self.mainVStack.spacing = 20
        
        self.currencyListHStack.axis = .vertical
        self.currencyListHStack.alignment = .trailing
        
        self.hStack.axis = .horizontal
        self.hStack.alignment = .fill
        self.hStack.distribution = .equalSpacing
        
        let currencyListButtonConfiguration = UIImage.SymbolConfiguration(pointSize: 35, weight: .thin)
        let currencyListButtonImage = UIImage(systemName: "globe", withConfiguration: currencyListButtonConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.currencyList.setImage(currencyListButtonImage, for: UIControl.State())
        
        let destinationArrowConfiguration = UIImage.SymbolConfiguration(pointSize: 35, weight: .semibold)
        let destinationArrowImage = UIImage(systemName: "arrow.right", withConfiguration: destinationArrowConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.desinationCurrencyArrow.image = destinationArrowImage
    }
}
