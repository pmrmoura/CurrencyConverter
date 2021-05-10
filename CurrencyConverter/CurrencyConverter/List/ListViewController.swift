//
//  ListViewController.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import UIKit
import Combine

final class ListViewController: UIViewController {
//    private let viewModel: ConvertViewModel
//    private let convertView: ConvertView = ConvertView()
//    private var bindings = Set<AnyCancellable>()

//    init(viewModel: ConvertViewModel = ConvertViewModel()) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func loadView() {
        self.view = ListView()
        self.title = "Moedas disponíveis"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTargets()
        setupBindings()
    }
    
    func setupTargets() {
        //
    }
    
    func setupBindings() {
        //
    }
}
