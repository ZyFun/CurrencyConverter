//
//  UserDefaultService.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 26.08.2022.
//

import Foundation

protocol IUserDefaultsService {
    func set(_ isFavorite: Bool, for currencyCode: String)
    func loadFavoriteFor(_ currencyCode: String) -> Bool
}

final class UserDefaultsService: IUserDefaultsService {
    static let shared = UserDefaultsService()
    
    private let userDefaults = UserDefaults()
    
    private init(){}
    
    #warning("Возможно я не так понял задачу, и нужно было сохранять именно как data, чтобы был доступ даже с отсутствующей сетью.")
    func set(_ isFavorite: Bool, for currencyCode: String) {
        DispatchQueue.global().async {
            self.userDefaults.set(isFavorite, forKey: currencyCode)
        }
    }
    
    func loadFavoriteFor(_ currencyCode: String) -> Bool {
        userDefaults.bool(forKey: currencyCode)
    }
    
}
