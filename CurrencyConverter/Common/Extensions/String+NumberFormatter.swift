//
//  String+NumberFormatter.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 24.08.2022.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "ru_Ru")
        let double = formatter.number(from: self)
        return double as? Double
    }
}
