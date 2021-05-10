//
//  KeyboardView.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 09/05/21.
//

import UIKit

final class KeyboardView: UIView, ViewCode {
    lazy var mainHStack = UIStackView()
    lazy var numbersVStack = UIStackView()
    lazy var featuresVStack = UIStackView()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        self.addSubview(self.mainHStack)
        self.mainHStack.translatesAutoresizingMaskIntoConstraints = false
        
        [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"], ["0", ",", "A"], ["T", "B"]]
            .forEach {
                let line = UIStackView()
                line.axis = .horizontal
                line.alignment = .fill
                line.distribution = .equalSpacing
                line.translatesAutoresizingMaskIntoConstraints = false
                self.mainHStack.addArrangedSubview(line)
                
                $0.forEach {
                    let numberButton = UIButton()
                    if ($0 == "1") {
                        numberButton.tag = 1
                    }
                    numberButton.setTitle($0, for: UIControl.State())
                    numberButton.setTitleColor(.black, for: UIControl.State())
                    numberButton.backgroundColor = UIColor(white: 0.9, alpha: 1)
                    numberButton.layer.cornerRadius = 20
                    numberButton.clipsToBounds = true
                    NSLayoutConstraint.activate([
                        numberButton.heightAnchor.constraint(equalToConstant: 60),
                        numberButton.widthAnchor.constraint(equalToConstant: 60)
                    ])
                    numberButton.translatesAutoresizingMaskIntoConstraints = false
                    line.addArrangedSubview(numberButton)
                }
            }
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            self.mainHStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainHStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainHStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainHStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.mainHStack.axis = .vertical
        self.mainHStack.alignment = .fill
        self.mainHStack.distribution = .fillProportionally
        self.mainHStack.spacing = 20

    }
    
}
