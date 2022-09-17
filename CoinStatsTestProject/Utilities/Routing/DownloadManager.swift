//
//  DownloadManager.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

final class DownloadManager: DownloadManagable {

    var cacher: Cachable
    var downloader: Downloadable
    
    required init(cacher: Cachable, downloader: Downloadable) {
        self.cacher = cacher
        self.downloader = downloader
    }
    
    func download(from url: URL) -> Single<Data> {
        return downloader.download(from: url)
    }
    
    func downloadFile(from url: URL) -> Single<URL> {
        return downloader.download(from: url)
    }
    
    func cancelDownload(for url: URL) {
        downloader.cancel(for: url)
    }
    
    func progress(for url: URL) -> Progress? {
        downloader.progress(for: url)
    }
}
