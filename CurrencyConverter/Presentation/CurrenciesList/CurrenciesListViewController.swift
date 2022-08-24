//
//  CurrenciesListViewController.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit

protocol CurrenciesListDisplayLogic: AnyObject {
    func displayCurrencies(_ currencies: [CRBApiModel]?)
}

final class CurrenciesListViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CurrenciesListViewControllerOutput?
    var dataSourceProvider: ICurrenciesListDataSourceProvider?

    // MARK: - Outlets
    
    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        activityIndicator.startAnimating()
        presenter?.loadingData()
    }
}

// MARK: - Private methods

private extension CurrenciesListViewController {
    func setup() {
        setupNavigationBar()
        setupTableView()
        setupActivityIndicator()
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
    
    func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
    }
}


// MARK: - CurrenciesListDisplayLogic

extension CurrenciesListViewController: CurrenciesListDisplayLogic {
    func displayCurrencies(_ currencies: [CRBApiModel]?) {
        DispatchQueue.main.async {
            self.dataSourceProvider?.currencies = currencies
            self.currenciesTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}
