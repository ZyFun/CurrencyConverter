//
//  CurrenciesListPresenter.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

protocol CurrenciesListPresentationLogic: AnyObject {
    func displayCurrencies(_ currencies: [CRBApiModel]?)
}

protocol CurrenciesListViewControllerOutput {
    func loadingData()
}

final class CurrenciesListPresenter {
    
    // MARK: - Public properties
    
    weak var view: CurrenciesListDisplayLogic?
    var interactor: CurrenciesListBusinessLogic?
    var router: CurrenciesListRoutingLogic?
}

// MARK: - CurrenciesListPresentationLogic

extension CurrenciesListPresenter: CurrenciesListPresentationLogic {
    func displayCurrencies(_ currencies: [CRBApiModel]?) {
        view?.displayCurrencies(currencies)
    }
}

// MARK: - CurrenciesListViewControllerOutput

extension CurrenciesListPresenter: CurrenciesListViewControllerOutput {
    func loadingData() {
        interactor?.loadingData()
    }
}
