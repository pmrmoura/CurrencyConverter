//
//  ListViewController.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import UIKit
import Combine

final class ListViewController: UIViewController {
    var currencies: [String: String] = ["": ""]
    
    let viewModel: ListViewModel
    private var bindings = Set<AnyCancellable>()
    
    lazy var listView = ListView()
    var currencieList: [String: String] = ["": ""] {
        didSet {
            self.currencies = currencieList
            self.listView.tableView.reloadData()
        }
    }
    
    init(viewModel: ListViewModel = ListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Moedas disponíveis"
        self.setupTableView()
        self.setupBindings()
        
        let okButton = UIBarButtonItem(title: "Cancelar", style: .done, target: self, action: #selector(self.dismissListView))
        self.navigationItem.rightBarButtonItem = okButton
    }

      override func loadView() {
        self.view = listView
      }
    
    @objc func dismissListView() {
        self.viewModel.chosenCurrency = .none
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupBindings() {
        viewModel.$currencies
            .assign(to: \.currencieList, on: self)
            .store(in: &bindings)
        
        viewModel.$isLoading
            .assign(to: \.isLoading, on: self.listView)
            .store(in: &bindings)
        
        let stateValueHandler: (ListViewModelState) -> Void = { [weak self] state in
            switch state {
            case .loading:
                self?.listView.startLoading()
            case .finishedLoading:
                self?.listView.finishLoading()
            case .error(let error):
                self?.listView.finishLoading()
                self?.showError(error)
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
    
      func setupTableView() {
        listView.tableView.register(CurrencyCell.self, forCellReuseIdentifier: "cellID")
        listView.tableView.dataSource = self
        listView.tableView.delegate = self
        self.viewModel.fetchCurrencies()
      }
    
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Erro", message: "Ocorreu um erro ao listar as moedas disponíveis", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencies.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let countryCell = listView.tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
    
    guard let cell = countryCell as? CurrencyCell else {
        fatalError("")
    }
    
    cell.selectionStyle = viewModel.isSelectabled ? .default : .none
    
    let itemToShow = Array(self.currencies)[indexPath.row]
    
    cell.countryFlag.text = flag(country: itemToShow.key)
    cell.countryCode.text = itemToShow.value
    cell.countryName.text = itemToShow.key

    return cell
  }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if (viewModel.isSelectabled) {
            dismiss(animated: false, completion: nil)
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
    
        guard let selectedCell = cell as? CurrencyCell else { return }
        
        let selectedCurrency = Currency(currencyCode: selectedCell.countryName.text!, countryName: selectedCell.countryCode.text!, countryFlag: selectedCell.countryFlag.text!)
        
        viewModel.selectCurrency(selectedCurrency: selectedCurrency)
    }
}
