//
//  ListViewModel.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import Foundation
import Combine

enum ListViewModelState {
    case loading
    case finishedLoading
    case error(Error)
}

enum ChosenCurrency {
    case none
    case origin
    case destination
}

final class ListViewModel {
    @Published private(set) var currencies: [String: String] = ["": ""]
    @Published private(set) var state: ListViewModelState = .loading
    @Published var isLoading = false
    @Published var isSelectabled = false
    @Published var selectedCurrency: Currency
    @Published var chosenCurrency: ChosenCurrency = .none
    
    private var bindings = Set<AnyCancellable>()
    private let listService: ListCurrencyServices
    
    init(listService: ListCurrencyServices = ListCurrencyServices()) {
        self.listService = listService
        self.selectedCurrency = Currency(currencyCode: "BRL", countryName: "Brazil", countryFlag: "")
    }
    
    func fetchCurrencies() {
        state = .loading
        
        self.isLoading = true
        
        let searchTermCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error): self?.state = .error(error)
            case .finished: self?.state = .finishedLoading
            }
        }
        
        let searchTermValueHandler: ([String: String]) -> Void = { [weak self] currencies in
            self?.currencies = currencies
            self?.isLoading = false
        }
        
        self.listService
            .get()
            .sink(receiveCompletion: searchTermCompletionHandler, receiveValue: searchTermValueHandler)
            .store(in: &bindings)
    }
    
    func selectCurrency(selectedCurrency: Currency) {
        self.selectedCurrency = selectedCurrency
    }
}
