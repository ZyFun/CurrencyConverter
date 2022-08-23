//
//  CRBApiModel.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

struct CRBApiModel: Codable {
    let charCode: String?
    let name: String?
    let valueRub: String?
}
