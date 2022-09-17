//
//  DownloadManagable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation
import RxSwift

protocol DownloadManagable {
    var cacher: Cachable { get }
    var downloader: Downloadable { get }
    
    init(cacher: Cachable, downloader: Downloadable)
    
    func download(from url: URL) -> Single<Data>
    func downloadFile(from url: URL) -> Single<URL>
    
    func cancelDownload(for url: URL)
    func progress(for url: URL) -> Progress?
}
