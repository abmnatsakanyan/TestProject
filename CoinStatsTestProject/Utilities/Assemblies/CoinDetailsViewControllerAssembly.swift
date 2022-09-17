//
//  CoinDetailsViewControllerAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 17.09.22.
//

import Swinject

final class CoinDetailsViewControllerAssembly: Assembly {

    private let downloadManager: DownloadManagable

    init(downloadManager: DownloadManagable) {
        self.downloadManager = downloadManager
    }

    func assemble(container: Container) {
        container.register(CoinDetailViewModel.self) { resolver in
            let inputs = CoinDetailInput(coinService: resolver.resolve(CoinDetailsServicing.self)!, downloadService:  self.downloadManager)
            return CoinDetailViewModel(input: inputs)
        }

        container.register(CoinDetailsViewController.self) { resolver in
            let viewController = CoinDetailsViewController()
            viewController.viewModel = resolver.resolve(CoinDetailViewModel.self)!
            return viewController
        }
    }
}
