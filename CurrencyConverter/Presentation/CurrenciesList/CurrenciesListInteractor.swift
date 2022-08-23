//
//  CurrenciesListInteractor.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import Foundation

protocol CurrenciesListBusinessLogic {
    
}

final class CurrenciesListInteractor {
    
    // MARK: - Public properties
    
    weak var presenter: CurrenciesListPresentationLogic?
}

// MARK: - CurrenciesListBusinessLogic
extension CurrenciesListInteractor: CurrenciesListBusinessLogic {
    
}
