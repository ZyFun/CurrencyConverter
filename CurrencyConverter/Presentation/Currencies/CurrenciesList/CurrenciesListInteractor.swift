//
//  CurrenciesListInteractor.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

protocol CurrenciesListBusinessLogic {
    func loadingData()
}

final class CurrenciesListInteractor {
    
    // MARK: - Public properties
    
    weak var presenter: CurrenciesListPresentationLogic?
    var requestSender: RequestSender?
}

// MARK: - CurrenciesListBusinessLogic
extension CurrenciesListInteractor: CurrenciesListBusinessLogic {
    func loadingData() {
        let requestConfig = RequestFactory.CBRCurrencyRequest.modelConfig()
        requestSender?.send(config: requestConfig) { [weak self] result in
            switch result {
            case .success(let(models, _, _)):
                self?.presenter?.displayCurrencies(models)
            case .failure(let error):
                Logger.error(error.rawValue)
                self?.presenter?.showErrorAlertWith(error)
            }
        }
    }
}
