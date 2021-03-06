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
    lazy var selectCountriesVStack = UIStackView()
    lazy var valuesToConvertHStack = UIStackView()
    
    lazy var currencyList = UIButton()
    lazy var desinationCurrencyArrow = UIImageView()
    lazy var originValue = UILabel()
    lazy var destinationValue = UILabel()
    lazy var equalLabel = UILabel()
    
    lazy var originCurrency = SelectCountryView()
    lazy var destinationCurrency = SelectCountryView()
    lazy var keyboard = KeyboardView()
    
    lazy var activityIndicator = ActivityIndicatorView(style: .medium)
    
    var isLoading: Bool = false {
        didSet { isLoading ? startLoading() : finishLoading() }
    }
    
    var originValueText = "" {
        didSet {
            self.originValue.text = originValueText
        }
    }
    
    var destinationValueText = "" {
        didSet {
            self.destinationValue.text = destinationValueText
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading() {
        isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func finishLoading() {
        isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }
    
    func addSubViews() {
        self.addSubview(mainVStack)
        self.mainVStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        [currencyListHStack, selectCountriesVStack, valuesToConvertHStack, keyboard]
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
                selectCountriesVStack.addArrangedSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        [originValue, equalLabel, destinationValue]
            .forEach {
                valuesToConvertHStack.addArrangedSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            self.mainVStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.mainVStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.mainVStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            self.mainVStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
            
            self.currencyListHStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.currencyListHStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.selectCountriesVStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.selectCountriesVStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.valuesToConvertHStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.valuesToConvertHStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.keyboard.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.keyboard.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
        
        self.mainVStack.axis = .vertical
        self.mainVStack.alignment = .center
        self.mainVStack.distribution = .fillProportionally
        
        self.currencyListHStack.axis = .vertical
        self.currencyListHStack.alignment = .trailing
        
        self.selectCountriesVStack.axis = .horizontal
        self.selectCountriesVStack.alignment = .center
        self.selectCountriesVStack.distribution = .equalSpacing
        
        self.valuesToConvertHStack.axis = .horizontal
        self.valuesToConvertHStack.alignment = .center
        self.valuesToConvertHStack.distribution = .fillEqually
        
        let currencyListButtonConfiguration = UIImage.SymbolConfiguration(pointSize: 35, weight: .thin)
        let currencyListButtonImage = UIImage(systemName: "globe", withConfiguration: currencyListButtonConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.currencyList.setImage(currencyListButtonImage, for: UIControl.State())
        
        let destinationArrowConfiguration = UIImage.SymbolConfiguration(pointSize: 35, weight: .thin)
        let destinationArrowImage = UIImage(systemName: "arrow.right", withConfiguration: destinationArrowConfiguration)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        self.desinationCurrencyArrow.image = destinationArrowImage
        
        self.originValue.text = originValueText
        self.originValue.font = UIFont.systemFont(ofSize: 64, weight: .thin)
        self.originValue.textAlignment = .left
        self.originValue.adjustsFontSizeToFitWidth = true
        self.originValue.numberOfLines = 1
        self.originValue.minimumScaleFactor = 0.2
        
        self.equalLabel.text = "="
        self.equalLabel.font = UIFont.systemFont(ofSize: 64, weight: .thin)
        self.equalLabel.textAlignment = .center
        
        self.destinationValue.text = "0"
        self.destinationValue.font = UIFont.systemFont(ofSize: 64, weight: .thin)
        self.destinationValue.textAlignment = .right
        self.destinationValue.adjustsFontSizeToFitWidth = true
        self.destinationValue.numberOfLines = 1
        self.destinationValue.minimumScaleFactor = 0.2
    }
}
