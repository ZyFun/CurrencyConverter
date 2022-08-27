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
    var dataSourceProvider: ICurrenciesDataSourceProvider?
    
    // MARK: - Private properties
    
    /// Используется для передачи данных на экран Favorites
    private var currencies: [CRBApiModel]?

    // MARK: - Outlets
    
    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Использую для обновления ячеек, после возврата с экрана избранного
        currenciesTableView.reloadData()
    }
    
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
        
        setupBarButtons()
    }
    
    func setupBarButtons() {
        createFavoriteButton()
    }
    
    func createFavoriteButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(favoriteBarButtonPressed), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func favoriteBarButtonPressed() {
        presenter?.routeToFavorite(with: currencies, dataSourceProvider)
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
        self.currencies = currencies
        
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