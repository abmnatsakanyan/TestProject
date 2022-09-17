//
//  Parsable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

protocol Parsable {
    func parse<T: Decodable>(data: Data) -> Single<T>
}
