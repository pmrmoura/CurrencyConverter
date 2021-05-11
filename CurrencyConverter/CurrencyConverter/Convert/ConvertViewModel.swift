//
//  ConvertViewModel.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import Foundation
import Combine

enum ConvertViewModelState {
    case loading
    case finishedLoading
    case error(Error)
}

final class ConvertViewModel {
    @Published private(set) var state: ConvertViewModelState = .loading
    @Published var originCountry: Currency = Currency(currencyCode: "BRL", countryName: "Brazil", countryFlag: "🇧🇷")
    @Published var destinationCountry: Currency = Currency(currencyCode: "USD", countryName: "United States", countryFlag: "🇺🇸")
    @Published var originValue: String = "0"
    @Published var destinationValue: String = "0"
    @Published var exchangeRates: [String: Double] = ["": 0]
    @Published var isLoading: Bool = false
    
    private var bindings = Set<AnyCancellable>()
    private let exchangeRateService: GetExchangeRateServices
    
    init(exchangeRateService: GetExchangeRateServices = GetExchangeRateServices()) {
        self.exchangeRateService = exchangeRateService
    }
    
    func fetchExchangeRates() {
        state = .loading
        
        self.isLoading = true
        
        let searchTermCompletionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            print(completion)
            switch completion {
            case .failure(let error): self?.state = .error(error)
            case .finished: self?.state = .finishedLoading
            }
        }
        
        let searchTermValueHandler: ([String: Double]) -> Void = { [weak self] currencies in
            self?.exchangeRates = currencies
            self?.isLoading = false
            print(self?.exchangeRates)
        }
        
        self.exchangeRateService
            .get()
            .sink(receiveCompletion: searchTermCompletionHandler, receiveValue: searchTermValueHandler)
            .store(in: &bindings)
    }
    
    
    func handleNumberChange(number: String) {
        switch number {
        case "A":
            originValue = "0"
        case "B":
            originValue.removeLast()
            if (originValue.isEmpty) {
                originValue = "0"
            }
        case "T":
            (self.originCountry, self.destinationCountry) = (self.destinationCountry, self.originCountry)
        default:
            if originValue == "0" {
                originValue = number
            } else {
                originValue = originValue + number
            }
        }
        handleConvert()
    }
    
    func handleConvert() {
        let originValueWithPoint = Double(self.originValue.replacingOccurrences(of: ",", with: "."))
        let originCode = self.originCountry.currencyCode
        let destinationCode = self.destinationCountry.currencyCode
        var finalValue: Double = 0
        var rate:Double = 0
        
        if (originCode == destinationCode) {
            finalValue = originValueWithPoint!
        } else if (originCode == "USD"){
            rate = self.exchangeRates[originCode + destinationCode]!
            finalValue = originValueWithPoint! * rate
        } else if (destinationCode == "USD") {
            rate = self.exchangeRates[destinationCode + originCode]!
            finalValue = originValueWithPoint! / rate
        } else {
            let originRateToUSD = self.exchangeRates["USD\(originCode)"]
            
            let destinationRateFromUSD = self.exchangeRates["USD\(destinationCode)"]
            
            finalValue = (originValueWithPoint! / originRateToUSD!) * destinationRateFromUSD!
        }
        
//        print(rate)
        
        let roundedFinalValue = String(Double(round(1000 * finalValue) / 1000))
        
        self.destinationValue = roundedFinalValue
    }
    
    func setOriginCountry(selectedCurrency: Currency) {
        self.originCountry = selectedCurrency
    }
    
    func setDestinationCountry(selectedCurrency: Currency) {
        self.destinationCountry = selectedCurrency
    }
    
}
