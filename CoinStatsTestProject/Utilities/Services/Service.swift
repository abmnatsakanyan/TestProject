//
//  Service.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import RxSwift

class Service {
    private var dataFetchManager: DataFetchable
    
    init(dataFetchManager: DataFetchable) {
        self.dataFetchManager = dataFetchManager
    }
    
    func call<T: Decodable>(route: Routing) -> Single<T> {
        return dataFetchManager.fetch(route: route)
    }
}
