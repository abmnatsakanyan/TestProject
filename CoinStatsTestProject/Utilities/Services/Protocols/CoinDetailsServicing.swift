//
//  CoinDetailsServicing.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 17.09.22.
//

import RxSwift

protocol CoinDetailsServicing {
    func fetch(route: CoinDetailParams) -> Single<Coin>
}
