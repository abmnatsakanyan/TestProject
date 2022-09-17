//
//  CoinDetailParams.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 17.09.22.
//

import Foundation

struct CoinDetailParams: Routing {
    var id: String
    var key: RoutingAPI {
        return Constants.API.coinDetails(id: "\(id)")
    }
}
