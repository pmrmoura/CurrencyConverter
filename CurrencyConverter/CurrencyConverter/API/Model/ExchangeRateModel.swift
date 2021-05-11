//
//  ExchangeRateModel.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 11/05/21.
//

import Foundation

struct ExchangeRate: Decodable {
    let success: Bool
    let terms, privacy: String
    let timestamp: Int
    let source: String
    let quotes: [String: Double]
}
