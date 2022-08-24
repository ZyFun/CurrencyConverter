//
//  CalculatorInteractor.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 24.08.2022.
//

protocol CalculatorBusinessLogic {
    
}

final class CalculatorInteractor {
    
    // MARK: - Public properties
    
    weak var presenter: CalculatorPresentationLogic?
}

// MARK: - CalculatorBusinessLogic

extension CalculatorInteractor: CalculatorBusinessLogic {
    
}
