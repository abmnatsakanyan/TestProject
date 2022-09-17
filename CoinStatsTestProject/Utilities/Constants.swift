//
//  Constants.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

public enum Constants {

    public enum BaseURL {
        static let dev: URL = URL(string: "https://api.coin-stats.com/v3/")!
    }

    public enum API: RoutingAPI {

        case coins
        case coinArray
        case coinDetails(id: String)

        public var path: String {
            switch self {
            case .coins:
                return "coins"
            case .coinArray:
                return "coins?responseType=array"
            case .coinDetails(let id):
                return "coins/\(id)"
            }
        }

        public var fileName: String {
            switch self {
            case .coins:
                return "CoinsMock"
            case .coinArray:
                return "CoinsUpdateInfoMock"
            case .coinDetails(let id):
                return "CoinMock-\(id)"
            }
        }
    }

    public enum FileTypes: String {
        case json
    }
    
    enum NavigationTitles {
        static let coinsListViewControllerTitle = "Coin List"
        static let coinsDetailsViewControllerTitle = "Coin Details"
    }
    
    enum Errors {
        static let error = "Something went wrong."
        static let ok = "OK"
        static let done = "Done"
    }
}
