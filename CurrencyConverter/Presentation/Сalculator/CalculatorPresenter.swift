//
//  CalculatorPresenter.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 24.08.2022.
//

protocol CalculatorPresentationLogic: AnyObject {
    
}

protocol CalculatorViewControllerOutput {
    
}

final class CalculatorPresenter {
    
    // MARK: - Public properties
    
    weak var view: CalculatorDisplayLogic?
    var interactor: CalculatorBusinessLogic?
}

// MARK: - CalculatorPresentationLogic

extension CalculatorPresenter: CalculatorPresentationLogic {
    
}

// MARK: - CalculatorViewControllerOutput

extension CalculatorPresenter: CalculatorViewControllerOutput {
    
}
