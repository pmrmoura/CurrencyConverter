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

import Foundation

struct CurrencyListModelError: Decodable {
    var code: Int
    var info: String
}

struct CurrencyListModel: Decodable {
    let success: Bool
    let terms, privacy: String
    let currencies: [String: String]
}
