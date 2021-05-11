//
//  SelectCountryView.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 09/05/21.
//

import UIKit

final class SelectCountryView: UIView, ViewCode {

    lazy var mainStackView = UIStackView()
    lazy var countryStackView = UIStackView()
    lazy var countryFlag = UILabel()
    lazy var currencyCode = UILabel()
    lazy var tapToChange = UILabel()
    
    var selectedCountry: Currency = Currency(currencyCode: "BRL", countryName: "Brazi", countryFlag: "") {
        didSet {
            countryFlag.text = selectedCountry.countryFlag
            currencyCode.text = selectedCountry.currencyCode
        }
    }

    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        [mainStackView]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        [countryFlag, currencyCode]
            .forEach {
                countryStackView.addArrangedSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
        [countryStackView, tapToChange]
            .forEach {
                mainStackView.addArrangedSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        mainStackView.axis = .vertical
        mainStackView.alignment  = .center
        
        countryStackView.axis = .horizontal
        countryStackView.alignment = .center
        countryStackView.spacing = 15
        
        countryFlag.text = "🇧🇷"
        countryFlag.font = UIFont.systemFont(ofSize: 42)
        countryFlag.adjustsFontSizeToFitWidth = true
        countryFlag.minimumScaleFactor = 0.5
        
        currencyCode.text = "BRL"
        currencyCode.font = UIFont.systemFont(ofSize: 42, weight: .thin)
        currencyCode.adjustsFontSizeToFitWidth = true
        currencyCode.minimumScaleFactor = 0.5
        
        tapToChange.text = "Toque para mudar"
        tapToChange.font = UIFont.systemFont(ofSize: 16, weight: .thin)
    }
}
