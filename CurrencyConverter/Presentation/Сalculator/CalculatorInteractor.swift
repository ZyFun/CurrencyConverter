//
//  CalculatorInteractor.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 24.08.2022.
//

protocol CalculatorBusinessLogic {
    func fetchFirstData()
    func convert(to type: CurrencyType, amountCurrency: Double, amountRub: Double)
}

final class CalculatorInteractor {
    
    // MARK: - Public properties
    
    weak var presenter: CalculatorPresentationLogic?
    var currentCurrency: CRBApiModel?
}

// MARK: - CalculatorBusinessLogic

extension CalculatorInteractor: CalculatorBusinessLogic {
    func convert(
        to type: CurrencyType,
        amountCurrency: Double,
        amountRub: Double
    ) {
        guard let charCode = currentCurrency?.charCode else { return }
        guard let nominal = currentCurrency?.nominal?.doubleValue else { return }
        guard var rubValue = currentCurrency?.valueRub?.doubleValue else { return }
        
        if nominal != 1 {
            rubValue /= nominal
        }
        
        switch type {
        case .rub:
            let result = amountCurrency * rubValue
            presenter?.presentConversion(.rub, result, with: "RUB")
        case .other:
            let result = 1 / rubValue * amountRub
            presenter?.presentConversion(.other, result, with: charCode)
        }
    }
    
    func fetchFirstData() {
        presenter?.presentFirstData(currency: currentCurrency)
    }
}
