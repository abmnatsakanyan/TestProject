//
//  CoinsServicing.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import RxSwift

protocol CoinsServicing {
    func fetch(route: CoinsParams) -> Single<CoinResponse>
    func fetchUpdates(route: CoinsParams) -> Single<CoinUpdateInfoResponse>
}
