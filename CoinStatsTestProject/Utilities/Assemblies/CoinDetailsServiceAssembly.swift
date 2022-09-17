//
//  CoinDetailsServiceAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 17.09.22.
//

import Swinject

final class CoinDetailsServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CoinDetailsServicing.self) { _ in
            if AppEnvironment.current == .mock {
                return CoinDetailMockService(dataFetchManager: DataFetchManagerProvider.mock)
            }
            return CoinDetailsService(dataFetchManager: DataFetchManagerProvider.web)
        }
    }
}
