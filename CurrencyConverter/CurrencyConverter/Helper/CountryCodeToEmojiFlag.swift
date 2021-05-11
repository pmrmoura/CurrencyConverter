//
//  CountryCodeToEmojiFlag.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 11/05/21.
//

import Foundation

func flag(country:String) -> String {
    let base : UInt32 = 127397
    var s = ""
    for v in country.unicodeScalars {
        s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
    }
    return String(s.first ?? Character("🇧🇷"))
}
