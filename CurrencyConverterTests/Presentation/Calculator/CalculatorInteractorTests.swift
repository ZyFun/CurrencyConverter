//
//  CalculatorInteractorTests.swift
//  CurrencyConverterTests
//
//  Created by Дмитрий Данилин on 26.08.2022.
//

import XCTest
@testable import CurrencyConverterZyFun

final class CalculatorInteractorTests: XCTestCase {
    
    private var presenter = CalculatorPresenterMock()
    private var interactor: CalculatorInteractor!
    
    override func setUp() {
        super.setUp()
        
        interactor = CalculatorInteractor()
        interactor.presenter = presenter
    }
    
    func testConvertCurrencyToRubWithCommaInValue() {
        // Given
        let charCode = "USD"
        let nominal = "1"
        let valueRub = "25,50"
        let amountCurrency = 2.0
        let amountRub = 0.0
        interactor.currentCurrency = CRBApiModel(charCode: charCode, nominal: nominal, name: nil, valueRub: valueRub)
        
        // When
        interactor.convert(to: .rub, amountCurrency: amountCurrency, amountRub: amountRub)
        let param = presenter.invokedPresentConversionParameters
        
        // Then
        XCTAssertEqual(param?.result, 51)
    }
    
    func testConvertRubToCurrency() {
        // Given
        let charCode = "RUB"
        let nominal = "1"
        let valueRub = "60"
        let amountCurrency = 0.0
        let amountRub = 240.0
        let CurrencyModel = CRBApiModel(charCode: charCode, nominal: nominal, name: nil, valueRub: valueRub)
        
        // When
        interactor.currentCurrency = CurrencyModel
        interactor.convert(to: .other, amountCurrency: amountCurrency, amountRub: amountRub)
        let param = presenter.invokedPresentConversionParameters
        
        // Then
        XCTAssertEqual(param?.result, 4)
    }
    
    func testWithNominalConvert() {
        // Given
        let charCode = "RUB"
        let nominal = "10"
        let valueRub = "60"
        let amountCurrency = 0.0
        let amountRub = 120.0
        let CurrencyModel = CRBApiModel(charCode: charCode, nominal: nominal, name: nil, valueRub: valueRub)
        
        // When
        interactor.currentCurrency = CurrencyModel
        interactor.convert(to: .other, amountCurrency: amountCurrency, amountRub: amountRub)
        let param = presenter.invokedPresentConversionParameters
        
        // Then
        XCTAssertEqual(param?.result, 20)
    }
    
    func testCharCodeIsEmpty() {
        // Given
        let nominal = "10"
        let name = "Test"
        let valueRub = "60"
        let amountCurrency = 0.0
        let amountRub = 120.0
        let currencyModel = CRBApiModel(charCode: nil, nominal: nominal, name: name, valueRub: valueRub)

        // When
        interactor.currentCurrency = currencyModel
        interactor.convert(to: .other, amountCurrency: amountCurrency, amountRub: amountRub)
        let param = presenter.invokedPresentConversionParameters
        
        // Then
        XCTAssertNil(param?.charCode)
    }
    
    func testNominalNotDouble() {
        // Given
        let charCode = "RUB"
        let nominal = "Foo"
        let name = "Test"
        let valueRub = "60"
        let amountCurrency = 0.0
        let amountRub = 120.0
        let currencyModel = CRBApiModel(charCode: charCode, nominal: nominal, name: name, valueRub: valueRub)

        // When
        interactor.currentCurrency = currencyModel
        interactor.convert(to: .other, amountCurrency: amountCurrency, amountRub: amountRub)
        let param = presenter.invokedPresentConversionParameters
        
        // Then
        XCTAssertNotNil(interactor.currentCurrency?.nominal)
        XCTAssertEqual(param?.result, 0)
    }
    
    func testValueRubNotDouble() {
        // Given
        let charCode = "RUB"
        let nominal = "1"
        let name = "Test"
        let valueRub = "Test"
        let amountCurrency = 0.0
        let amountRub = 120.0
        let currencyModel = CRBApiModel(charCode: charCode, nominal: nominal, name: name, valueRub: valueRub)

        // When
        interactor.currentCurrency = currencyModel
        interactor.convert(to: .other, amountCurrency: amountCurrency, amountRub: amountRub)
        let param = presenter.invokedPresentConversionParameters
        
        
        // Then
        XCTAssertNotNil(interactor.currentCurrency?.valueRub)
        XCTAssertTrue(param!.result.isInfinite)
    }
    
    func testFetchFirstData() {
        // Given
        let charCode = "RUB"
        let nominal = "10"
        let name = "Test"
        let valueRub = "60"
        let currencyModel = CRBApiModel(charCode: charCode, nominal: nominal, name: name, valueRub: valueRub)
        
        // When
        interactor.currentCurrency = currencyModel
        interactor.fetchFirstData()
        let param = presenter.invokedPresentFirstDataParameters
        
        // Then
        XCTAssertEqual(param?.currency?.charCode, currencyModel.charCode)
        XCTAssertEqual(param?.currency?.nominal, currencyModel.nominal)
        XCTAssertEqual(param?.currency?.name, currencyModel.name)
        XCTAssertEqual(param?.currency?.valueRub, currencyModel.valueRub)
    }
    
}
