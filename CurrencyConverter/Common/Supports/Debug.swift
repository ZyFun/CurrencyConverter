//
//  Debug.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 28.08.2022.
//

public func printDebug(_ items: Any...) {
    #if DEBUG
    for item in items {
        Swift.print(item)
    }
    #endif
}
