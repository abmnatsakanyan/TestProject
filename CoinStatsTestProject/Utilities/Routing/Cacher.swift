//
//  Cacher.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

final class Cacher: Cachable {
    
    private var safeCache: [URL: Data] = [:]
    private var safeFileCache: [URL: URL] = [:]
    private var safeQueue: DispatchQueue = DispatchQueue(label: "com.Coins.Caching", attributes: .concurrent)
    private var safeFileQueue: DispatchQueue = DispatchQueue(label: "com.Coins.FileCaching", attributes: .concurrent)

    var cache: [URL: Data] {
        safeQueue.sync {
            return safeCache
        }
    }
    
    var fileCache: [URL: URL] {
        safeFileQueue.sync {
            return safeFileCache
        }
    }
    
    func add(_ data: Data, url: URL) {
        safeQueue.async(flags: .barrier) {[weak self] in
            self?.safeCache.updateValue(data, forKey: url)
        }
    }
    
    func addFile(at path: URL, remote: URL) {
        safeFileQueue.async(flags: .barrier) {[weak self] in
            self?.safeFileCache.updateValue(path, forKey: remote)
        }
    }
    
    func remove(for url: URL) {
        safeQueue.async(flags: .barrier) {[weak self] in
            self?.safeCache.removeValue(forKey: url)
        }
    }
    
    func removeFile(for url: URL) {
        safeFileQueue.async(flags: .barrier) {[weak self] in
            self?.safeFileCache.removeValue(forKey: url)
        }
    }
}
