//
//  CoinsListViewControllerAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import Swinject

final class CoinsListViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(CoinsListViewModel.self) { resolver in
            let input = CoinsInputs(coinService: resolver.resolve(CoinsServicing.self)!, downloadService: resolver.resolve(DownloadManagable.self)!)
            return CoinsListViewModel(input: input)
        }

        container.register(CoinsListViewController.self) { resolver in
            let viewController = CoinsListViewController()
            viewController.viewModel = resolver.resolve(CoinsListViewModel.self)
            return viewController
        }
    }
}
