//
//  Coin.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

struct Coin: Decodable {
    var identifier: String
    let name: String
    var iconUrl: URL?
    var symbol: String
    var rank: Int
    var priceUSD: Double?
    var priceBTC: Double?
    var volumeUSDForLastDay: Double?
    var marketCapInUSD: Int
    var percentChangeForHour: Double?
    var percentChangeForDay: Double?
    var percentChangeForWeek: Double?
    
    
    enum CodingKeys: String, CodingKey {
        case identifier = "i"
        case name = "n"
        case symbol = "s"
        case iconUrl = "ic"
        case rank = "r"
        case priceUSD = "pu"
        case priceBTC = "pb"
        case volumeUSDForLastDay = "v"
        case marketCapInUSD = "m"
        case percentChangeForHour = "p1"
        case percentChangeForDay = "p24"
        case percentChangeForWeek = "p7"
    }
}
