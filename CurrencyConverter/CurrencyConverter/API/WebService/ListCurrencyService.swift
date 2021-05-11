//
//  ListCurrencyService.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 10/05/21.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol CurrencyListServiceProtocol {
    func get() -> AnyPublisher<[String: String], Error>
}

private let apiKey = "2a341afd57ace687b1c32858f0e141ce"

final class ListCurrencyServices: CurrencyListServiceProtocol {
    func get() -> AnyPublisher<[String: String], Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.resume() }
        
        return Future<[String: String], Error> { promise in
            let url = URL(string: "http://api.currencylayer.com/list?access_key=\(apiKey)&format=1")!
            dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    let currencies = try JSONDecoder().decode(CurrencyListModel.self, from: data)
                    promise(.success(currencies.currencies))
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
