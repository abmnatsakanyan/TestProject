//
//  CoinsMockService.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import RxSwift

final class CoinsMockService: Service, CoinsServicing {
    func fetch(route: CoinsParams) -> Single<CoinResponse> {
        return call(route: route)
    }
    
    func fetchUpdates(route: CoinsParams) -> Single<CoinUpdateInfoResponse> {
        return call(route: route)
    }
}
