//
//  CurrenciesListConfigurator.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit

final class CurrenciesListConfigurator {
    func config(view: UIViewController, navigationController: UINavigationController?) {
        guard let view = view as? CurrenciesListViewController else { return }
        
        let presenter = CurrenciesListPresenter()
        let interactor = CurrenciesListInteractor()
        let router = CurrenciesListRouter(withNavigationController: navigationController)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        let dataSourceProvider = CurrenciesListDataSourceProvider(
            presenter: presenter
        )
        
        view.dataSourceProvider = dataSourceProvider
    }
}
