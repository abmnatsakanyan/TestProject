//
//  Downloader.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

final class Downloader: Downloadable {
    
    private var queue: DispatchQueue = .init(label: "com.Downloader")
    private var _tasks: [URL: URLSessionTask] = [:]
    private var tasks: [URL: URLSessionTask] {
        get {
            queue.sync {
                return _tasks
            }
        }
        
        set {
            queue.sync {
                self._tasks = newValue
            }
        }
    }
    
    func download(from url: URL) -> Single<Data> {
        return Single<Data>.create { [weak self] subscriber in
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: url) { [weak self] data, _, error in
                if let error = error {
                    if self?.tasks[url] != nil {
                        self?.tasks.removeValue(forKey: url)
                        subscriber(.failure(NetworkError.untracked(router: nil, error: error)))
                    }
                }
                guard let data = data else {
                    return subscriber(.failure(NetworkError.emptyData(router: nil)))
                }
                subscriber(.success(data))
            }
            dataTask.resume()
            self?.tasks.updateValue(dataTask, forKey: url)
            return Disposables.create {
                dataTask.cancel()
            }
        }
    }
    
    func download(from url: URL) -> Single<URL> {
        return Single<URL>.create { [weak self] subscriber in
            let session = URLSession(configuration: .default)
            let downloadTask = session.downloadTask(with: url) { url, _, error in
                if let error = error {
                    subscriber(.failure(NetworkError.untracked(router: nil, error: error)))
                }
                
                guard let url = url else {
                    return subscriber(.failure(NetworkError.emptyData(router: nil)))
                }
                subscriber(.success(url))
            }
            downloadTask.resume()
            self?.tasks.updateValue(downloadTask, forKey: url)
            return Disposables.create {
                downloadTask.cancel()
            }
        }
    }
    
    func progress(for url: URL) -> Progress? {
        return self.tasks[url]?.progress
    }
    
    func cancel(for url: URL) {
        tasks[url]?.cancel()
    }
}
