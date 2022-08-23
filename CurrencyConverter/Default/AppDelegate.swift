//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        createAndShowStartVC()
        
        return true
    }
    
}

// MARK: - Initial application settings

private extension AppDelegate {
    func createAndShowStartVC() {
        let mainVC = CurrenciesListViewController(
            nibName: String(describing: CurrenciesListViewController.self),
            bundle: nil
        )
        
        let navigationController = UINavigationController(
            rootViewController: mainVC
        )
        
        CurrenciesListConfigurator()
            .config(
                view: mainVC,
                navigationController: navigationController
            )
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

