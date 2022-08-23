//
//  CurrenciesListPresenter.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

protocol CurrenciesListPresentationLogic: AnyObject {
    
}

protocol CurrenciesListViewControllerOutput {
    
}

final class CurrenciesListPresenter {
    
    // MARK: - Public properties
    
    weak var view: CurrenciesListDisplayLogic?
    var interactor: CurrenciesListBusinessLogic?
    var router: CurrenciesListRoutingLogic?
}

// MARK: - CurrenciesListPresentationLogic

extension CurrenciesListPresenter: CurrenciesListPresentationLogic {
    
}

// MARK: - CurrenciesListViewControllerOutput

extension CurrenciesListPresenter: CurrenciesListViewControllerOutput {
    
}
