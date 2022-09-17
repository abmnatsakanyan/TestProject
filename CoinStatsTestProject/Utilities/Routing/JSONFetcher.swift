//
//  JSONFetcher.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

final class JSONFetcher: Fetchable {
    func fetch(route: Routing) -> Single<Data> {
        return Single<Data>.create { subscriber in
            let fileName = route.key.fileName
            
            if let path = Bundle.main.path(forResource: fileName, ofType: Constants.FileTypes.json.rawValue) {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    subscriber(.success(data))
                } catch let error {
                    subscriber(.failure(NetworkError.untracked(router: route, error: error)))
                }
            } else {
                subscriber(.failure(CommonError.fileNotExist(name: fileName, bundle: .main)))
            }
            return Disposables.create()
        }
    }
}
