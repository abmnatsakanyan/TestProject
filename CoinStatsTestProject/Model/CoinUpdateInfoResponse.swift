//
//  CoinUpdateInfoResponse.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 18.09.22.
//

import Foundation

struct CoinUpdateInfoResponse: Decodable {
    let coins: [CoinUpdateInfo]
}
