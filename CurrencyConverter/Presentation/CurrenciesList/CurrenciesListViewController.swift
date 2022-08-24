//
//  CurrenciesListViewController.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit

protocol CurrenciesListDisplayLogic: AnyObject {
    func displayCurrencies(_ currencies: [CRBApiModel]?)
    func showErrorAlertWith(_ error: NetworkError)
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
        
        // TODO: Сделать кеширование, и загружать данные раз в день. Всё остальное время доставать из памяти без обращения к сети
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
        
        title = "Выбор валюты"
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
    
    func showErrorAlertWith(_ error: NetworkError) {
        let message = error.rawValue
        
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        let repeatButton = UIAlertAction(
            title: "Повторить",
            style: .default
        ) { [weak self] _ in
            self?.activityIndicator.startAnimating()
            self?.presenter?.loadingData()
        }
        
        let cancelButton = UIAlertAction(
            title: "Отмена",
            style: .destructive
        ) { [weak self] _ in
            self?.activityIndicator.stopAnimating()
        }
        
        alert.addAction(repeatButton)
        alert.addAction(cancelButton)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
