//
//  CoinResponse.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 17.09.22.
//

import Foundation

struct CoinResponse: Decodable {
    let coins: [Coin]
}
