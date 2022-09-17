//
//  Cachable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

protocol Cachable {
    var cache: [URL: Data] { get }
    var fileCache: [URL: URL] { get }
    
    func add(_ data: Data, url: URL)
    func addFile(at path: URL, remote: URL)
    func removeFile(for url: URL)
    func remove(for url: URL)
}
