//
//  JSONFetcherAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Swinject

final class JSONFetcherAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Fetchable.self) { _ in
            return JSONFetcher()
        }
    }
}
