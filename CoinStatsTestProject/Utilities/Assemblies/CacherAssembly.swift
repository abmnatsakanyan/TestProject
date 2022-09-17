//
//  CacherAssembly.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Swinject

final class CacherAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Cachable.self) { _ in
            return Cacher()
        }
    }
}
