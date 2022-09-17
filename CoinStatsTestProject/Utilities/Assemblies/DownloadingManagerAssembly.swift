//
//  DownloadingManagerAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Swinject

final class DownloadingManagerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DownloadManagable.self) { resolver in
            return DownloadManager(cacher: resolver.resolve(Cachable.self)!, downloader: resolver.resolve(Downloadable.self)!)
        }
    }
}
