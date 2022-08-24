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
    @IBOutlet weak var firstSumTF: UITextField!
    @IBOutlet weak var secondSumTF: UITextField!
    @IBOutlet weak var shiftButton: UIButton!
    @IBOutlet weak var calculationButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
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
}


// MARK: - CalculatorDisplayLogic

extension CalculatorViewController: CalculatorDisplayLogic {
    
}

