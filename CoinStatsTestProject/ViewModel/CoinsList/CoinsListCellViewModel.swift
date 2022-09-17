//
//  CoinsListCellViewModel.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import RxSwift

struct CoinsListCellViewModel: Hashable {
    
    let downloadManager: DownloadManagable
    let name: String
    let symbol: String
    var rank: String
    var price: String
    let id: String
    var percentChangeForDay: String?
    var isHiddenPercentView: Bool
    var percentViewBGColor: UIColor
    var percentTextColor: UIColor
    let imageURL: URL?
    var percentImage: UIImage?

    init(downloadManager: DownloadManagable,
         name: String,
         symbol: String,
         rank: String,
         price: String,
         id: String,
         percentChangeForDay: String? = nil,
         isHiddenPercentView: Bool,
         percentViewBGColor: UIColor,
         percentTextColor: UIColor,
         imageURL: URL? = nil,
         percentImage: UIImage? = nil) {
        self.downloadManager = downloadManager
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.price = price
        self.id = id
        self.percentChangeForDay = percentChangeForDay
        self.isHiddenPercentView = isHiddenPercentView
        self.percentViewBGColor = percentViewBGColor
        self.percentTextColor = percentTextColor
        self.imageURL = imageURL
        self.percentImage = percentImage
    }
    
    func downloadImage() -> Observable<UIImage> {
        guard let imageURL = imageURL else { return Observable<UIImage>.create { subscriber in
            subscriber.onNext(UIImage(named: "no_image_available")!)
            return Disposables.create()
        }}
        
        return downloadManager.download(from: imageURL)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .compactMap { UIImage(data: $0) }
            .asDriver(onErrorJustReturn: UIImage(named: "no_image_available")!)
            .asObservable()
    }

    func cancelDownloading() {
        guard let imageURL = imageURL else { return }
        
        downloadManager.cancelDownload(for: imageURL)
    }
    
    static func == (lhs: CoinsListCellViewModel, rhs: CoinsListCellViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
