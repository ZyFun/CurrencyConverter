//
//  CurrenciesDataSourceProvider.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit

protocol ICurrenciesDataSourceProvider: UITableViewDelegate, UITableViewDataSource {
    
    var currencies: [CRBApiModel]? { get set }
    var favoriteCurrencies: [CRBApiModel]? { get set }
}

final class CurrenciesDataSourceProvider: NSObject, ICurrenciesDataSourceProvider {
    
    // MARK: - Public properties
    
    var currencies: [CRBApiModel]?
    var favoriteCurrencies: [CRBApiModel]?
    
    // MARK: - Private properties
    
    private var presenter: CurrenciesListViewControllerOutput
    private var userDefaultService: IUserDefaultsService
    
    // MARK: - Initializer
    
    init(
        presenter: CurrenciesListViewControllerOutput,
        userDefaultService: IUserDefaultsService
    ) {
        self.presenter = presenter
        self.userDefaultService = userDefaultService
        super.init()
    }
}

// MARK: - Table view data source

extension CurrenciesDataSourceProvider {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        favoriteCurrencies != nil
        ? favoriteCurrencies?.count ?? 0
        : currencies?.count ?? 0
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrencyCell.identifier,
            for: indexPath
        ) as? CurrencyCell else {
            return UITableViewCell()
        }
        
        let currency = favoriteCurrencies != nil
        ? favoriteCurrencies?[indexPath.row]
        : currencies?[indexPath.row]
        
        guard let currency = currency else { return UITableViewCell() }
        
        cell.config(
            charCode: currency.charCode,
            nominal: currency.nominal,
            name: currency.name,
            value: currency.valueRub,
            isFavorite: userDefaultService.loadFavoriteFor(currency.charCode ?? "")
        )
        
        return cell
    }
}

// MARK: - Table view delegate

extension CurrenciesDataSourceProvider {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let currency = currencies?[indexPath.row] else {
            Logger.error("Выбранная валюта не доступна")
            return
        }
        
        presenter.routeToCalculator(with: currency)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let currency = favoriteCurrencies != nil
        ? favoriteCurrencies?[indexPath.row]
        : currencies?[indexPath.row]
        
        guard let charCode = currency?.charCode else { return nil }
        let isFavorite = userDefaultService.loadFavoriteFor(charCode)
        
        let favoriteAction = UIContextualAction(
            style: .normal,
            title: "Favorite"
        ) { [weak self] _, _, isDone in
            guard let self = self else { return }
            
            if isFavorite {
                self.userDefaultService.set(false, for: charCode)
                
                if self.favoriteCurrencies != nil {
                    self.favoriteCurrencies?.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            } else {
                self.userDefaultService.set(true, for: charCode)
            }
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            isDone(true)
        }
        
        favoriteAction.backgroundColor = isFavorite ? .gray : .orange
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}
