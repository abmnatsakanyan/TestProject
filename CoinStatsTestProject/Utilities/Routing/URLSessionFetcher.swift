//
//  URLSessionFetcher.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

final class URLSessionFetcher: Fetchable {
    
    func fetch(route: Routing) -> Single<Data> {
        return Single<Data>.create { subscriber in
            do {
                let request = try route.request()
                let session = URLSession(configuration: .default)
                let dataTask = session.dataTask(with: request) { data, response, error in
                    if let error = error {
                        subscriber(.failure(NetworkError.untracked(router: route, error: error)))
                    }
                    
                    guard let response = response as? HTTPURLResponse, route.acceptableStatusCode.contains(response.statusCode) else {
                        subscriber(.failure(NetworkError.invalideResponse(router: route)))
                        return
                    }
                    
                    guard let data = data else {
                        return subscriber(.failure(NetworkError.emptyData(router: route)))
                    }
                    
                    subscriber(.success(data))
                 }
                dataTask.resume()
            } catch let error {
                subscriber(.failure(NetworkError.untracked(router: route, error: error)))
            }
            return Disposables.create()
        }
    }
}
