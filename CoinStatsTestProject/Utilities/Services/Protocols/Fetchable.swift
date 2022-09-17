//
//  Fetchable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

protocol Fetchable {
    func fetch(route: Routing) -> Single<Data>
}
