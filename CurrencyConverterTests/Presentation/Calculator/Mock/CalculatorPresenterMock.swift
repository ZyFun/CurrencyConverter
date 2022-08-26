//
//  CalculatorPresenterMock.swift
//  CurrencyConverterTests
//
//  Created by Дмитрий Данилин on 26.08.2022.
//

@testable import CurrencyConverter

final class CalculatorPresenterMock: CalculatorPresentationLogic {

    var invokedPresentFirstData = false
    var invokedPresentFirstDataCount = 0
    var invokedPresentFirstDataParameters: (currency: CRBApiModel?, Void)?
    var invokedPresentFirstDataParametersList = [(currency: CRBApiModel?, Void)]()

    func presentFirstData(currency: CRBApiModel?) {
        invokedPresentFirstData = true
        invokedPresentFirstDataCount += 1
        invokedPresentFirstDataParameters = (currency, ())
        invokedPresentFirstDataParametersList.append((currency, ()))
    }

    var invokedPresentConversion = false
    var invokedPresentConversionCount = 0
    var invokedPresentConversionParameters: (currency: CurrencyType, result: Double, charCode: String)?
    var invokedPresentConversionParametersList = [(currency: CurrencyType, result: Double, charCode: String)]()

    func presentConversion(_ currency: CurrencyType, _ result: Double, with charCode: String) {
        invokedPresentConversion = true
        invokedPresentConversionCount += 1
        invokedPresentConversionParameters = (currency, result, charCode)
        invokedPresentConversionParametersList.append((currency, result, charCode))
    }
}
