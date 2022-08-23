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
        
    }
}

// MARK: - CurrenciesListRoutingLogic

extension CurrenciesListRouter: CurrenciesListRoutingLogic {
    func routeTo(target: Targets) {
        
    }
}
