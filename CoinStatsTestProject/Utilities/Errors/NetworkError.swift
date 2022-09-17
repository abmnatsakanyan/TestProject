//
//  NetworkError.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

enum NetworkError: LocalizedError {

    case emptyData(router: Routing?)
    case invalideResponse(router: Routing?)
    case attempToEncodePrarmeters(_ parameters: [String: Any])
    case untracked(router: Routing?, error: Error)
    
    var errorDescription: String? {
        switch self {
        case .emptyData:
            return Constants.Errors.error
        case .invalideResponse:
            return Constants.Errors.error
        case .attempToEncodePrarmeters(let pararmets):
            return Constants.Errors.error + " " + pararmets.description
        case .untracked(let router, let error):
            return "Router: \(String(describing: router)), error:" + error.localizedDescription
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .emptyData:
            return Constants.Errors.error
        case .invalideResponse:
            return Constants.Errors.error
        case .attempToEncodePrarmeters(let pararmets):
            return Constants.Errors.error + " " + pararmets.description
        default: return "Unfilled"
        }
    }
}
