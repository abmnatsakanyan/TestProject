//
//  CoinUpdateInfo.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 18.09.22.
//

import Foundation

class CoinUpdateInfo: Decodable {
    let identifier: String
    let rank: Int?
    let priceUSD: Double?
    let priceBTC: Double?
    let volumeUSDForLastDay: Double?
    let marketCapInUSD: Int?
    let percentChangeForHour: Double?
    let percentChangeForDay: Double?
    let percentChangeForWeek: Double?
    
    required init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        let array = try container.decode([Any].self)
        
        identifier = array[0] as? String  ?? ""
        rank = array[1] as? Int
        priceUSD = array[2] as? Double
        priceBTC = array[3] as? Double
        volumeUSDForLastDay = array[4] as? Double
        marketCapInUSD = array[5] as? Int
        percentChangeForHour = array[6] as? Double
        percentChangeForDay = array[7] as? Double
        percentChangeForWeek = array[8] as? Double
    }
}
