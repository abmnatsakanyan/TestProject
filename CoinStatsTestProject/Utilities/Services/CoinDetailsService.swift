//
//  CoinDetailsService.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 17.09.22.
//

import RxSwift

final class CoinDetailsService: Service, CoinDetailsServicing {
    func fetch(route: CoinDetailParams) -> Single<Coin> {
        return call(route: route)
    }
}
