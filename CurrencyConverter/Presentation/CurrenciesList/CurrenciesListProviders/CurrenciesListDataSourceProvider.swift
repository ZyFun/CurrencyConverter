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
    
    private var presenter: CurrenciesListViewControllerOutput?
    
    // MARK: - Initializer
    
    init(presenter: CurrenciesListViewControllerOutput?) {
        self.presenter = presenter
        super.init()
    }
}

// MARK: - Table view data source

extension CurrenciesListDataSourceProvider {
    
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
            value: currency.valueRub
        )
        
        return cell
    }
}

// MARK: - Table view delegate

extension CurrenciesListDataSourceProvider {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
