//
//  CommonError.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

enum CommonError: LocalizedError {
    case missingSelf
    case fileNotExist(name: String, bundle: Bundle)
}
