//
//  JsonDecoder.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

final class JsonDecoder: Parsable {
    
    func parse<T>(data: Data) -> Single<T> where T: Decodable {
        Single.create { closure in
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                closure(.success(decodedData))
            } catch let error {
                closure(.failure(error))
            }
            return Disposables.create()
        }
    }
}
