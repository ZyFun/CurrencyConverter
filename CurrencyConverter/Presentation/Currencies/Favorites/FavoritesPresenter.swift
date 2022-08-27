//
//  FavoritePresenter.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 27.08.2022.
//

protocol FavoritesPresentationLogic: AnyObject {
    func presentFavorite(_ currencies: [CRBApiModel])
}

protocol FavoritesViewControllerOutput {
    func filterFavorite()
}

final class FavoritesPresenter {
    
    // MARK: - Public properties
    
    weak var view: FavoritesDisplayLogic?
    var interactor: FavoritesBusinessLogic?
}

// MARK: - CurrenciesListPresentationLogic

extension FavoritesPresenter: FavoritesPresentationLogic {
    func presentFavorite(_ currencies: [CRBApiModel]) {
        view?.displayFavorite(currencies)
    }
}

// MARK: - CurrenciesListViewControllerOutput

extension FavoritesPresenter: FavoritesViewControllerOutput {
    func filterFavorite() {
        interactor?.filterFavorite()
    }
}
