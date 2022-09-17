//
//  CoinsServiceAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Swinject

final class CoinsServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CoinsServicing.self) { _ in
            if AppEnvironment.current == .mock {
                return CoinsMockService(dataFetchManager: DataFetchManagerProvider.mock)
            }
            return CoinsService(dataFetchManager: DataFetchManagerProvider.web)
        }
    }
}
