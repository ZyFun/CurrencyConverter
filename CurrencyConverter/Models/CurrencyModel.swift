//
//  CurrencyModel.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

struct CurrencyModel {
    let charCode: String
    let name: String
    let valueRub: Double
    
    static func getStubCurrency() -> [CurrencyModel] {
        [
            CurrencyModel(charCode: "EUR", name: "Евро", valueRub: 63.43),
            CurrencyModel(charCode: "USD", name: "Доллар", valueRub: 60.43),
            CurrencyModel(charCode: "BTC", name: "Биткоин", valueRub: 2360.43),
            CurrencyModel(charCode: "EUR", name: "Евро", valueRub: 63.43),
            CurrencyModel(charCode: "USD", name: "Доллар", valueRub: 60.43),
            CurrencyModel(charCode: "BTC", name: "Биткоин", valueRub: 2360.43),
            CurrencyModel(charCode: "EUR", name: "Евро", valueRub: 63.43),
            CurrencyModel(charCode: "USD", name: "Доллар", valueRub: 60.43),
            CurrencyModel(charCode: "BTC", name: "Биткоин", valueRub: 2360.43),
            CurrencyModel(charCode: "EUR", name: "Евро", valueRub: 63.43),
            CurrencyModel(charCode: "USD", name: "Доллар", valueRub: 60.43),
            CurrencyModel(charCode: "BTC", name: "Биткоин", valueRub: 2360.43)
        ]
    }
}
