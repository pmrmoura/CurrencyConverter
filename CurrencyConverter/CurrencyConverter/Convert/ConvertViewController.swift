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
        // Do any additional setup after loading the view.
        
        setupTargets()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
    }
    
    func setupBindings() {
        viewModel.$originValue
            .assign(to: \.originValueText, on: convertView)
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

}
