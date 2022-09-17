//
//  JSONDecoderParserAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Swinject

final class JSONDecoderParserAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Parsable.self) { _ in
            return JsonDecoder()
        }
    }
}
