//
//  CurrenciesListDataSourceProvider.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit

protocol ICurrenciesListDataSourceProvider: UITableViewDelegate,
                                            UITableViewDataSource {
    
    var currencies: [CRBApiModel]? { get set }
}

final class CurrenciesListDataSourceProvider: NSObject, ICurrenciesListDataSourceProvider {
    
    // MARK: - Public properties
    
    var currencies: [CRBApiModel]?
    
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

extension CurrenciesListDataSourceProvider {
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        guard let currency = currencies?[indexPath.row] else { return nil }
        guard let charCode = currency.charCode else { return nil }
        let isFavorite = userDefaultService.loadFavoriteFor(charCode)
        
        let favoriteAction = UIContextualAction(
            style: .normal,
            title: "Favorite"
        ) { [weak self] _, _, isDone in
            guard let self = self else { return }
            
            if isFavorite {
                self.userDefaultService.set(false, for: charCode)
            } else {
                self.userDefaultService.set(true, for: charCode)
            }
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            isDone(true)
        }
        
        if isFavorite {
            favoriteAction.backgroundColor = .gray
        } else {
            favoriteAction.backgroundColor = .orange
        }
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        currencies?.count ?? 0
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
        
        guard let currency = currencies?[indexPath.row] else {
            return UITableViewCell()
        }
        
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

extension CurrenciesListDataSourceProvider {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let currency = currencies?[indexPath.row] else {
            print("Выбранная валюта не доступна")
            return
        }
        
        presenter.routeToCalculator(with: currency)
    }
}
