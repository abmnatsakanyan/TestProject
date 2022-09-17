//
//  DownloaderAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Swinject

final class DownloaderAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Downloadable.self) { _ in
            return Downloader()
        }
    }
}
