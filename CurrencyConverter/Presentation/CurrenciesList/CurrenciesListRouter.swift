//
//  CurrenciesListRouter.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit

protocol CurrenciesListRoutingLogic {
    func routeTo(target: CurrenciesListRouter.Targets)
}

final class CurrenciesListRouter {
    private var navigationController: UINavigationController?
    
    init(withNavigationController: UINavigationController?) {
        navigationController = withNavigationController
    }
    
    enum Targets {
        case calculator(CRBApiModel)
    }
}

// MARK: - CurrenciesListRoutingLogic

extension CurrenciesListRouter: CurrenciesListRoutingLogic {
    func routeTo(target: Targets) {
        switch target {
        case .calculator(let currentCurrency):
            let calculatorVC = CalculatorViewController(
                nibName: String(describing: CalculatorViewController.self),
                bundle: nil
            )
            
            CalculatorConfigurator().config(
                view: calculatorVC,
                navigationController: navigationController,
                currentCurrency: currentCurrency
            )
            
            navigationController?.pushViewController(calculatorVC, animated: true)
        }
    }
}
