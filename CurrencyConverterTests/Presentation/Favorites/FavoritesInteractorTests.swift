//
//  FavoritesInteractorTests.swift
//  CurrencyConverterTests
//
//  Created by Дмитрий Данилин on 27.08.2022.
//

import XCTest

@testable import CurrencyConverter

final class FavoritesInteractorTests: XCTestCase {
    
    private var presenter = FavoritesPresenterMock()
    private var interactor: FavoritesInteractor!
    
    override func setUp() {
        super.setUp()
        
        interactor = FavoritesInteractor()
        interactor.presenter = presenter
        interactor.userDefaultService = UserDefaultsService.shared
        
    }
    
    func testFilterFavoriteReturnNotNil() {
        // Given
        let charCode = "Test"
        let nominal = "1"
        let name = "Test"
        let valueRub = "60"
        interactor.loadedCurrencies = [CRBApiModel(
            charCode: charCode,
            nominal: nominal,
            name: name,
            valueRub: valueRub
        )]
        
        // When
        interactor.filterFavorite()
        
        // Then
        XCTAssertNotNil(presenter.invokedPresentFavoriteParameters?.currencies)
    }
    
    func testFilterFavoriteSetFavoriteEndAppendToFavoriteArray() {
        // Given
        let charCode = "Foo"
        let nominal = "1"
        let name = "Foo"
        let valueRub = "60"
        interactor.loadedCurrencies = [CRBApiModel(
            charCode: charCode,
            nominal: nominal,
            name: name,
            valueRub: valueRub
        )]
        
        // When
        interactor.userDefaultService?.set(true, for: charCode)
        interactor.filterFavorite()
        
        // Then
        XCTAssertFalse(presenter.invokedPresentFavoriteParameters!.currencies.isEmpty)
        XCTAssertTrue(interactor.userDefaultService!.loadFavoriteFor(charCode))
    }
}
