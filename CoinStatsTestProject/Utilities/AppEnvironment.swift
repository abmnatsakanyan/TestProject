//
//  AppEnvironment.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

enum AppEnvironment {

    case mock
    case web
    static private(set) var current: AppEnvironment = .web

    static func setup() {
        #if MOCK
        AppEnvironment.current = .mock
        #else
        AppEnvironment.current = .web
        #endif
    }
}
