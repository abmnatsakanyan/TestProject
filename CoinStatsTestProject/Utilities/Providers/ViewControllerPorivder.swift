//
//  ViewControllerPorivder.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import Swinject

enum ViewControllerPorivder: ProviderRouter {
    case coinsList
    case coinDetails(coinCell: CoinsListCellViewModel)

    var module: UIViewController? {
        switch self {
        case .coinsList:
            let assemblies: [Assembly] = [CoinsServiceAssembly(), DownloaderAssembly(), CacherAssembly(), DownloadingManagerAssembly(), CoinsListViewControllerAssembly()]
            let assembler: Assembler = Assembler(assemblies)
            return assembler.resolver.resolve(CoinsListViewController.self)
        case .coinDetails(let coinCell):
            let assemblies: [Assembly] = [CoinDetailsServiceAssembly(), DownloaderAssembly(), CacherAssembly(), DownloadingManagerAssembly(), CoinDetailsViewControllerAssembly(downloadManager: coinCell.downloadManager)]
            let assembler: Assembler = Assembler(assemblies)
            let controller = assembler.resolver.resolve(CoinDetailsViewController.self)
            controller?.viewModel.setup(coinID: coinCell.id)
            return controller
        }
    }
}
