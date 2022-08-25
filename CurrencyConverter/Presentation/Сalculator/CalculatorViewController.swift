//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 24.08.2022.
//

import UIKit

protocol CalculatorDisplayLogic: AnyObject {
    
}

final class CalculatorViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CalculatorViewControllerOutput?
    var currentCurrency: CRBApiModel?

    // MARK: - Outlets
    
    @IBOutlet weak var firstCharCodeLabel: UILabel!
    @IBOutlet weak var secondCharCodeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var amountCurrencyTF: UITextField!
    @IBOutlet weak var amountRubTF: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    
    // MARK: - Actions
    
    @IBAction func valueFirstTFDidChanged() {
        convertToRub()
    }
    
    @IBAction func valueSecondTFDidChanged() {
        convertToCurrency()
    }
}

// MARK: - Private methods

private extension CalculatorViewController {
    func setup() {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = currentCurrency?.name
    }
    
    
    func convertToRub() {
        guard let nominal = currentCurrency?.nominal?.doubleValue else { return }
        guard var rubValue = currentCurrency?.valueRub?.doubleValue else { return }
        guard let amountCurrency = amountCurrencyTF.text?.doubleValue else { return }
        
        if nominal != 1 {
            rubValue /= nominal
        }
        
        let conversionResult = amountCurrency * rubValue
        
        amountRubTF.text = String(format: "%.4f", conversionResult)
        resultLabel.text = String(format: "Сумма: %.4f RUB", conversionResult)
    }
    
    func convertToCurrency() {
        guard let charCode = currentCurrency?.charCode else { return }
        guard let nominal = currentCurrency?.nominal?.doubleValue else { return }
        guard var rubValue = currentCurrency?.valueRub?.doubleValue else { return }
        guard let amountRub = amountRubTF.text?.doubleValue else { return }
        
        if nominal != 1 {
            rubValue /= nominal
        }
        
        let conversionResult = 1 / rubValue * amountRub
        
        amountCurrencyTF.text = String(format: "%.4f", conversionResult)
        resultLabel.text = String(format: "Сумма: %.4f \(charCode)", conversionResult)
    }
}


// MARK: - CalculatorDisplayLogic

extension CalculatorViewController: CalculatorDisplayLogic {
    
}

