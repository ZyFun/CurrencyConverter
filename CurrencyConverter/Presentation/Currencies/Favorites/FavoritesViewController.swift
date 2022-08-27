//
//  FavoriteViewController.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 27.08.2022.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func displayFavorite(_ currencies: [CRBApiModel])
}

final class FavoritesViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: FavoritesViewControllerOutput?
    var dataSourceProvider: ICurrenciesDataSourceProvider?

    // MARK: - Outlets
    
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var emptyFavoritesLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        presenter?.filterFavorite()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Обнуляю массив для правильной работы data source
        dataSourceProvider?.favoriteCurrencies = nil
    }
}

// MARK: - Private methods

private extension FavoritesViewController {
    func setup() {
        setupNavigationBar()
        setupTableView()
    }
    
    func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .always
        
        title = "Избранное"
    }
    
    func setupTableView() {
        favoriteTableView.delegate = dataSourceProvider
        favoriteTableView.dataSource = dataSourceProvider
        
        registerCell()
    }
    
    func registerCell() {
        favoriteTableView.register(
            CurrencyCell.self,
            forCellReuseIdentifier: CurrencyCell.identifier
        )
    }
}


// MARK: - FavoriteDisplayLogic

extension FavoritesViewController: FavoritesDisplayLogic {
    func displayFavorite(_ currencies: [CRBApiModel]) {
        dataSourceProvider?.favoriteCurrencies = currencies
        emptyFavoritesLabel.isHidden = !currencies.isEmpty
    }
}
