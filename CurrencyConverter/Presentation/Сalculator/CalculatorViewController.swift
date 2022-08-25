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
        setupTextFields()
    }
    
    func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        title = currentCurrency?.name
    }
    
    func setupTextFields() {
        amountCurrencyTF.delegate = self
        amountRubTF.delegate = self
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

// MARK: - UITextFieldDelegate

extension CalculatorViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let currentText = textField.text else { return false }
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if updatedText.count <= 11 && string != "." && string != "," {
            return true
        } else {
            if string == "." || string == "," {
                let countDots = currentText.components(separatedBy: [".", ","]).count - 1
                if countDots == 0 && updatedText.count > 1 {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
    }
}

// MARK: - CalculatorDisplayLogic

extension CalculatorViewController: CalculatorDisplayLogic {
    
}

