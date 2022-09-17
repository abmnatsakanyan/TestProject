//
//  DataFetchable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

protocol DataFetchable {
    var fetcher: Fetchable { get }
    var parser: Parsable { get }
    
    init(fetcher: Fetchable, parser: Parsable)
    
    func fetch<T: Decodable>(route: Routing) -> Single<T>
}
