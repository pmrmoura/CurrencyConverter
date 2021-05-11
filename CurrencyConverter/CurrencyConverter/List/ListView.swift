//
//  ListView.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import UIKit

final class ListView: UIView, ViewCode {
    var tableView = UITableView()
    
    lazy var activityIndicator = ActivityIndicatorView(style: .medium)
    
    var isLoading: Bool = false {
        didSet { isLoading ? startLoading() : finishLoading() }
    }

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
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
        self.addSubview(self.tableView)
        self.addSubview(activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    func setupAdditionalConfiguration() {
        //
    }
}
