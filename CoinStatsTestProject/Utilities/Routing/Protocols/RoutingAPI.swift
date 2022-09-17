//
//  RoutingAPI.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

public protocol RoutingAPI {
    var path: String { get }
    var fileName: String { get }
}
