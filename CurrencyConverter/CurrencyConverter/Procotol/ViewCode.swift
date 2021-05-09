//
//  ViewCode.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import Foundation

protocol ViewCode {
    func addSubViews()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCode {
    func setupView() {
        addSubViews()
        setupContraints()
        setupAdditionalConfiguration()
    }
}
