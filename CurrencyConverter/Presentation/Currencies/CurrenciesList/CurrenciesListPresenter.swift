//
//  CurrenciesListPresenter.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

protocol CurrenciesListPresentationLogic: AnyObject {
    func displayCurrencies(_ currencies: [CRBApiModel]?)
    func showErrorAlertWith(_ error: NetworkError)
    func dismissSplashScreen()
}

protocol CurrenciesListViewControllerOutput {
    func loadingData()
    func routeToCalculator(with currency: CRBApiModel)
    func routeToFavorite(
        with currencies: [CRBApiModel]?,
        _ dataSourceProvider: ICurrenciesDataSourceProvider?
    )
}

final class CurrenciesListPresenter {
    
    // MARK: - Public properties
    
    weak var view: CurrenciesListDisplayLogic?
    var interactor: CurrenciesListBusinessLogic?
    var router: CurrenciesListRoutingLogic?
}

// MARK: - CurrenciesListPresentationLogic

extension CurrenciesListPresenter: CurrenciesListPresentationLogic {
    func dismissSplashScreen() {
        view?.dismissSplashScreen()
    }
    
    func showErrorAlertWith(_ error: NetworkError) {
        view?.showErrorAlertWith(error)
    }
    
    func displayCurrencies(_ currencies: [CRBApiModel]?) {
        view?.displayCurrencies(currencies)
    }
}

// MARK: - CurrenciesListViewControllerOutput

extension CurrenciesListPresenter: CurrenciesListViewControllerOutput {
    
    func loadingData() {
        interactor?.loadingData()
    }
    
    func routeToCalculator(with currency: CRBApiModel) {
        router?.routeTo(target: .calculator(currency))
    }
    
    func routeToFavorite(
        with currencies: [CRBApiModel]?,
        _ dataSourceProvider: ICurrenciesDataSourceProvider?
    ) {
        router?.routeTo(target: .favorite(dataSourceProvider, currencies))
    }
}
