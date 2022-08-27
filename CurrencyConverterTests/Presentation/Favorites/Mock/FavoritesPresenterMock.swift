//
//  FavoritesPresenterMock.swift
//  CurrencyConverterTests
//
//  Created by Дмитрий Данилин on 27.08.2022.
//

@testable import CurrencyConverter

final class FavoritesPresenterMock: FavoritesPresentationLogic {

    var invokedPresentFavorite = false
    var invokedPresentFavoriteCount = 0
    var invokedPresentFavoriteParameters: (currencies: [CRBApiModel], Void)?
    var invokedPresentFavoriteParametersList = [(currencies: [CRBApiModel], Void)]()

    func presentFavorite(_ currencies: [CRBApiModel]) {
        invokedPresentFavorite = true
        invokedPresentFavoriteCount += 1
        invokedPresentFavoriteParameters = (currencies, ())
        invokedPresentFavoriteParametersList.append((currencies, ()))
    }
}
