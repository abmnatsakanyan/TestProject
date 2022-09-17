//
//  ProviderRouter.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

protocol ProviderRouter {
    var module: UIViewController? { get }
}

extension ProviderRouter {
    func setRoot(in window: UIWindow, withNavigation: Bool) {
        guard let module = module else { return }
        
        window.rootViewController = withNavigation ? UINavigationController(rootViewController: module) : module
        window.makeKeyAndVisible()
    }
}
