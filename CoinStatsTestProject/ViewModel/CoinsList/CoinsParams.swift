//
//  CoinsParams.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

struct CoinsParams: Routing {
    ///  We can use this for pagination if api support
    var page: Int
    var onlyUpdates: Bool
    
    var key: RoutingAPI {
        return Constants.API.coins
    }
    
    var queryParameters: EncodableParameter {
        if onlyUpdates {
            return QueryParameter(parameters: ["responseType": "array"])
            
        }
        return QueryParameter(parameters: [:])
    }
}
