//
//  FavoriteConfigurator.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 27.08.2022.
//

import UIKit

final class FavoritesConfigurator {
    func config(
        view: UIViewController,
        navigationController: UINavigationController?,
        dataSourceProvider: ICurrenciesDataSourceProvider?,
        loadedCurrencies: [CRBApiModel]?
    ) {
        guard let view = view as? FavoritesViewController else { return }
        let presenter = FavoritesPresenter()
        let interactor = FavoritesInteractor()
        let userDefaultService = UserDefaultsService.shared
        
        view.presenter = presenter
        view.dataSourceProvider = dataSourceProvider
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.userDefaultService = userDefaultService
        interactor.loadedCurrencies = loadedCurrencies
    }
}
