//
//  CalculatorConfigurator.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 24.08.2022.
//

import UIKit

final class CalculatorConfigurator {
    func config(
        view: UIViewController,
        navigationController: UINavigationController?,
        currentCurrency: CRBApiModel
    ) {
        guard let view = view as? CalculatorViewController else { return }
        
        let presenter = CalculatorPresenter()
        let interactor = CalculatorInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.currentCurrency = currentCurrency
    }
}
