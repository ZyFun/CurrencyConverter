//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 24.08.2022.
//

import UIKit

protocol CalculatorDisplayLogic: AnyObject {
    func displayFirstData(name: String, nominal: String, valueRub: String, charCode: String)
    func displayConversion(currency: CurrencyType, _ result: String, and fullResult: String)
}

final class CalculatorViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CalculatorViewControllerOutput?

    // MARK: - Outlets
    
    @IBOutlet weak var currencyCharCodeLabel: UILabel!
    @IBOutlet weak var rubCharCodeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var amountCurrencyTF: UITextField!
    @IBOutlet weak var amountRubTF: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.fetchFirstData()
    }
    
    // MARK: - Actions
    
    @IBAction func valueCurrencyTFDidChanged() {
        presenter?.convert(
            to: .rub,
            amountCurrency: amountCurrencyTF.text,
            amountRub: amountRubTF.text
        )
    }
    
    @IBAction func valueRubTFDidChanged() {
        presenter?.convert(
            to: .other,
            amountCurrency: amountCurrencyTF.text,
            amountRub: amountRubTF.text
        )
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
    }
    
    func setupTextFields() {
        amountCurrencyTF.delegate = self
        amountRubTF.delegate = self
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
    func displayConversion(currency: CurrencyType, _ result: String, and fullResult: String) {
        resultLabel.isHidden = false
        
        switch currency {
        case .rub:
            amountRubTF.text = result
        case .other:
            amountCurrencyTF.text = result
        }
        
        resultLabel.text = fullResult
    }
    
    func displayFirstData(name: String, nominal: String, valueRub: String, charCode: String) {
        title = name
        amountCurrencyTF.text = nominal
        amountRubTF.text = valueRub
        currencyCharCodeLabel.text = charCode
        resultLabel.isHidden = true
    }
}
