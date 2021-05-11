//
//  CurrencyListModel.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 10/05/21.
//

import Foundation

//struct CurrencyListModel: Decodable {
//    var success: Bool?
//    var terms: String?
//    var privacy: String?
//    var currencies: Dictionary<String, String>?
//}

struct CurrencyListModelError: Decodable {
    var code: Int
    var info: String
}

import Foundation

// MARK: - Welcome
struct CurrencyListModel: Decodable {
    let success: Bool
    let terms, privacy: String
    let currencies: [String: String]
}

// MARK: - Currencies
struct Currencies: Codable {
    let aed, afn, all, amd: String
    let ang: String

    enum CodingKeys: String, CodingKey {
        case aed = "AED"
        case afn = "AFN"
        case all = "ALL"
        case amd = "AMD"
        case ang = "ANG"
    }
}
