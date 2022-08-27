//
//  FavoriteInteractor.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 27.08.2022.
//

protocol FavoritesBusinessLogic {
    func filterFavorite()
}

final class FavoritesInteractor {
    
    // MARK: - Public properties
    
    weak var presenter: FavoritesPresentationLogic?
    var userDefaultService: UserDefaultsService?
    var loadedCurrencies: [CRBApiModel]?
}

// MARK: - CurrenciesListBusinessLogic
extension FavoritesInteractor: FavoritesBusinessLogic {
    func filterFavorite() {
        guard let userDefaultService = userDefaultService else { return }
        var favoriteCurrencies: [CRBApiModel] = []
        
        loadedCurrencies?.forEach({ currency in
            if let charCode = currency.charCode {
                if userDefaultService.loadFavoriteFor(charCode) {
                    favoriteCurrencies.append(currency)
                }
            }
        })
        
        presenter?.presentFavorite(favoriteCurrencies)
    }
}
