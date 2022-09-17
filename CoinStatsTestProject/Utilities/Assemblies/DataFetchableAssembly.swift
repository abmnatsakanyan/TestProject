//
//  DataFetchableAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Swinject

final class DataFetchableAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DataFetchable.self) { resolver in
            return DataFetchManager(fetcher: resolver.resolve(Fetchable.self)!, parser: resolver.resolve(Parsable.self)!)
        }
    }
}
