//
//  ConvertViewModel.swift
//  CurrencyConverter
//
//  Created by Pedro Moura on 08/05/21.
//

import Foundation
import Combine

final class ConvertViewModel {
    @Published var originValue: String = "0"
    @Published var destinationValue: String = ""
    
    func handleNumberChange(number: String) {
        switch number {
        case "A":
            originValue = "0"
        case "B":
            originValue.removeLast()
            if (originValue.isEmpty) {
                originValue = "0"
            }
        default:
            if originValue == "0" {
                originValue = number
            } else {
                originValue = originValue + number
            }
        }
    }
    
}
