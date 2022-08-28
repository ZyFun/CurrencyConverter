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
    func dismissSplashScreen()
}

final class CurrenciesListViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: CurrenciesListViewControllerOutput?
    var dataSourceProvider: ICurrenciesDataSourceProvider?
    var splashPresenter: ISplashPresenter?
    
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
        
        showSplashScreen()
        setup()
        getCurrencies()
    }
}

// MARK: - Private methods

private extension CurrenciesListViewController {
    
    func showSplashScreen() {
        splashPresenter?.present()
    }
    
    func setup() {
        setupNavigationBar()
        setupTableView()
        setupActivityIndicator()
        setupRefreshControl()
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
    
    func setupRefreshControl() {
        currenciesTableView.refreshControl = UIRefreshControl()
        currenciesTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Обновление курса валют")
        currenciesTableView.refreshControl?.addTarget(self, action: #selector(getCurrencies), for: .valueChanged)
    }
    
    // TODO: Сделать кеширование через CoreData с сохранением избранного там же, вместо userDefaults
    @objc func getCurrencies() {
        activityIndicator.startAnimating()
        presenter?.loadingData()
    }
}


// MARK: - CurrenciesListDisplayLogic

extension CurrenciesListViewController: CurrenciesListDisplayLogic {
    func dismissSplashScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.splashPresenter?.dismiss(completion: { [weak self] in
                self?.splashPresenter = nil
            })
        }
    }
    
    func displayCurrencies(_ currencies: [CRBApiModel]?) {
        self.currencies = currencies
        dataSourceProvider?.currencies = currencies
        
        DispatchQueue.main.async {
            self.currenciesTableView.reloadData()
            self.activityIndicator.stopAnimating()
            if self.currenciesTableView?.refreshControl != nil {
                self.currenciesTableView?.refreshControl?.endRefreshing()
            }
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
            self?.currenciesTableView.refreshControl?.endRefreshing()
        }
        
        alert.addAction(repeatButton)
        alert.addAction(cancelButton)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
