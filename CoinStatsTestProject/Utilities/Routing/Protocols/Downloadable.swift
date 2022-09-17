//
//  Downloadable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift
import RxRelay

protocol Downloadable {
    func download(from url: URL) -> Single<Data>
    func download(from url: URL) -> Single<URL>
    func progress(for url: URL) -> Progress?
    func cancel(for url: URL)
}
