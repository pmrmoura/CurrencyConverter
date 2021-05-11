//
//  GetExchangeRate.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 11/05/21.
//

import Foundation
import Combine

enum GetExchangeRateError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol GetExchangeRateProtocol {
    func get() -> AnyPublisher<[String: Double], Error>
}

private let apiKey = "2a341afd57ace687b1c32858f0e141ce"

final class GetExchangeRateServices: GetExchangeRateProtocol {
    func get() -> AnyPublisher<[String: Double], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.resume() }
        
        return Future<[String: Double], Error> { promise in
            let url = URL(string: "http://api.currencylayer.com/live?access_key=\(apiKey)&format=1")!
            dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                print(response)
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    let exchangeRates = try JSONDecoder().decode(ExchangeRate.self, from: data)
                    promise(.success(exchangeRates.quotes))
                } catch {
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}


