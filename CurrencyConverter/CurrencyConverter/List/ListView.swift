//
//  ListView.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import UIKit

final class ListView: UIView, ViewCode {
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        //
    }
    
    func setupContraints() {
        //
    }
    
    func setupAdditionalConfiguration() {
        //
    }
}
