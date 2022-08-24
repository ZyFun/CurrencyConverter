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

    // MARK: - Outlets
    
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
        
        title = "Калькулятор"
    }
}


// MARK: - CalculatorDisplayLogic

extension CalculatorViewController: CalculatorDisplayLogic {
    
}

