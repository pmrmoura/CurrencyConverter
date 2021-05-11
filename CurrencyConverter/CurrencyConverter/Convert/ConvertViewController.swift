//
//  ConvertCurrenciesController.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import UIKit
import Combine

final class ConvertViewController: UIViewController {
    private let viewModel: ConvertViewModel
    private let convertView: ConvertView = ConvertView()
    private var bindings = Set<AnyCancellable>()
    let listViewController = ListViewController()

    init(viewModel: ConvertViewModel = ConvertViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = convertView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        setupBindings()
        
        viewModel.fetchExchangeRates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        self.handleChosenCurrency()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupTargets() {
        let stackView = convertView.keyboard.mainHStack.arrangedSubviews as! [UIStackView]
        stackView.forEach {
            $0.arrangedSubviews.forEach {
                let button = $0 as! UIButton
                button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
            }
        }
        
        let currencyListButton = convertView.currencyList
        currencyListButton.addTarget(self, action: #selector(navigateToCurrencyList), for: .touchUpInside)
        
        let originCountryButton = convertView.originCurrency
        let tapOriginCountryButton = UITapGestureRecognizer(target: self, action: #selector(tapOriginCountry))
        originCountryButton.addGestureRecognizer(tapOriginCountryButton)
        
        let destinationCountryButton = convertView.destinationCurrency
        let tapDestinationCountryButton = UITapGestureRecognizer(target: self, action: #selector(tapDestinationCountry))
        destinationCountryButton.addGestureRecognizer(tapDestinationCountryButton)
    }
    
    @objc func tapOriginCountry() {
        listViewController.viewModel.isSelectabled = true
        listViewController.modalPresentationStyle = .fullScreen
        listViewController.viewModel.chosenCurrency = .origin
        present(listViewController, animated: true, completion: nil)
    }
    
    @objc func tapDestinationCountry() {
        listViewController.viewModel.isSelectabled = true
        listViewController.modalPresentationStyle = .fullScreen
        listViewController.viewModel.chosenCurrency = .destination
        present(listViewController, animated: true, completion: nil)
    }
    
    func setupBindings() {
        viewModel.$originValue
            .assign(to: \.originValueText, on: convertView)
            .store(in: &bindings)
        
        viewModel.$destinationValue
            .assign(to: \.destinationValueText, on: convertView)
            .store(in: &bindings)
        
        viewModel.$originCountry
            .assign(to: \.selectedCountry, on: convertView.originCurrency)
            .store(in: &bindings)
        
        viewModel.$destinationCountry
            .assign(to: \.selectedCountry, on: convertView.destinationCurrency)
            .store(in: &bindings)
    }
    
    @objc func onClick(_ sender: AnyObject) {
        let value = String(sender.currentTitle!)
        viewModel.handleNumberChange(number: value)
    }
    
    @objc func navigateToCurrencyList() {
        let listViewController = ListViewController()
        navigationController?.pushViewController(listViewController, animated: true)
    }
    
    func handleChosenCurrency() {
        let chosenCurrency = listViewController.viewModel.chosenCurrency
        switch (chosenCurrency) {
        case .origin:
            viewModel.setOriginCountry(selectedCurrency: listViewController.viewModel.selectedCurrency)
        case .destination:
            viewModel.setDestinationCountry(selectedCurrency: listViewController.viewModel.selectedCurrency)
        case .none:
            print("none")
        }
    }

}
