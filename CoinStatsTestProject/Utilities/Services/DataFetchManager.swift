//
//  DataFetchManager.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import RxSwift

final class DataFetchManager: DataFetchable {

    var fetcher: Fetchable
    var parser: Parsable
    
    init(fetcher: Fetchable, parser: Parsable) {
        self.parser = parser
        self.fetcher = fetcher
    }
    
    func fetch<T>(route: Routing) -> Single<T> where T: Decodable {
        return fetcher.fetch(route: route).observe(on: MainScheduler.instance).flatMap { [weak self] data in
            guard let self = self else {
                return .error(CommonError.missingSelf)
            }
            
            return self.parser.parse(data: data)
        }
    }
}
