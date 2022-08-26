//
//  CalculatorPresenter.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 24.08.2022.
//

protocol CalculatorPresentationLogic: AnyObject {
    func presentFirstData(currency: CRBApiModel?)
    func presentConversion(_ currency: CurrencyType, _ result: Double, with charCode: String)
}

protocol CalculatorViewControllerOutput {
    func fetchFirstData()
    func convert(to type: CurrencyType, amountCurrency: String?, amountRub: String?)
}

final class CalculatorPresenter {
    
    // MARK: - Public properties
    
    weak var view: CalculatorDisplayLogic?
    var interactor: CalculatorBusinessLogic?
    
    private func convertResultToNumberString(_ result: Double) -> String {
        String(format: "%.4f", result)
    }
    
    private func convertResultToFullString(_ result: Double, with charCode: String) -> String {
        String(format: "Сумма: %.4f \(charCode)", result)
    }
}

// MARK: - CalculatorPresentationLogic

extension CalculatorPresenter: CalculatorPresentationLogic {
    func presentFirstData(currency: CRBApiModel?) {
        guard let name = currency?.name else { return }
        guard let nominal = currency?.nominal else { return }
        guard let valueRub = currency?.valueRub else { return }
        guard let charCode = currency?.charCode else { return }
        
        view?.displayFirstData(
            name: name,
            nominal: nominal,
            valueRub: valueRub,
            charCode: charCode
        )
    }
    
    func presentConversion(_ currency: CurrencyType, _ result: Double, with charCode: String) {
        let stringResult = convertResultToNumberString(result)
        let fullStringResult = convertResultToFullString(result, with: charCode)
        
        view?.displayConversion(currency: currency, stringResult, and: fullStringResult)
    }
}

// MARK: - CalculatorViewControllerOutput

extension CalculatorPresenter: CalculatorViewControllerOutput {
    func fetchFirstData() {
        interactor?.fetchFirstData()
    }
    
    func convert(to type: CurrencyType, amountCurrency: String?, amountRub: String?) {
        guard let amountCurrency = amountCurrency?.doubleValue else { return }
        guard let amountRub = amountRub?.doubleValue else { return }

        interactor?.convert(to: type, amountCurrency: amountCurrency, amountRub: amountRub)
    }
}
