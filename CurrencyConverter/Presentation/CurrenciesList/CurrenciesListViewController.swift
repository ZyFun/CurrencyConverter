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
    var dataSourceProvider: ICurrenciesListDataSourceProvider?

    // MARK: - Outlets
    
    @IBOutlet weak var currenciesTableView: UITableView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        dataSourceProvider?.currencies = CurrencyModel.getStubCurrency()
        
        presenter?.parse()
    }
}

// MARK: - Private methods

private extension CurrenciesListViewController {
    func setup() {
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        title = "Валюты"
    }
    
    func setupTableView() {
        currenciesTableView.delegate = dataSourceProvider
        currenciesTableView.dataSource = dataSourceProvider
        
        registerCell()
    }
    
    func registerCell() {
        currenciesTableView.register(
            CurrencyCell.self,
            forCellReuseIdentifier: CurrencyCell.identifier
        )
    }
}


// MARK: - CurrenciesListDisplayLogic

extension CurrenciesListViewController: CurrenciesListDisplayLogic {
    
}
