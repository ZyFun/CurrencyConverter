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
        
        let splashPresenter = SplashPresenter()
        let presenter = CurrenciesListPresenter()
        let interactor = CurrenciesListInteractor()
        let router = CurrenciesListRouter(withNavigationController: navigationController)
        let dataSourceProvider = CurrenciesDataSourceProvider(
            presenter: presenter,
            userDefaultService: UserDefaultsService.shared
        )
        let requestSender = RequestSender()
        
        view.splashPresenter = splashPresenter
        view.presenter = presenter
        view.dataSourceProvider = dataSourceProvider
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.requestSender = requestSender
    }
}
