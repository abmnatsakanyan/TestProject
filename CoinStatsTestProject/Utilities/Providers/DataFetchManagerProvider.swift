//
//  DataFetchManagerProvider.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Swinject

struct DataFetchManagerProvider {
    static func createDataFetchManager(_ assemblies: [Assembly]) -> DataFetchable {
        let assembler = Assembler(assemblies)
        return assembler.resolver.resolve(DataFetchable.self)!
    }

    static var mock: DataFetchable {
        return createDataFetchManager([JSONFetcherAssembly(), JSONDecoderParserAssembly(), DataFetchableAssembly()])
    }

    static var web: DataFetchable {
        return createDataFetchManager([URLSessionFetcherAassembly(), JSONDecoderParserAssembly(), DataFetchableAssembly()])
    }
}
