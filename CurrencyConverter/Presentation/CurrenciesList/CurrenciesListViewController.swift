//
//  CurrenciesListViewController.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit

protocol CurrenciesListDisplayLogic: AnyObject {
    
}

final class CurrenciesListViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CurrenciesListViewControllerOutput?

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - CurrenciesListDisplayLogic

extension CurrenciesListViewController: CurrenciesListDisplayLogic {
    
}
