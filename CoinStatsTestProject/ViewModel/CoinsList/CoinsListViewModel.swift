//
//  CoinsListViewModel.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import RxSwift
import RxRelay

final class CoinsListViewModel: BaseViewModel<CoinsInputs>, DataSource {
    typealias Section = CoinsSection
    var dataSource: BehaviorRelay<[CoinsSection]> = .init(value: [])
    let title: String = Constants.NavigationTitles.coinsListViewControllerTitle
    let usdBarItemTitle: String = "USD"
    private var page: Int = 1
    private var timerDisposeBag = DisposeBag()
    
    lazy var currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en-US")
        
        return currencyFormatter
    }()

    func fetchCoins() {
        self.isProcessing.accept(true)
        input.coinService.fetch(route: CoinsParams(page: page, onlyUpdates: false)).subscribe { [weak self] result in
            guard let self = self else {
                self?.error.accept(CommonError.missingSelf)
                self?.isProcessing.accept(false)
                return
            }
            
            let coinsCellViewModel = result.coins.compactMap { self.createCell(coin: $0) }
            let section = self.dataSource.value.first ?? CoinsSection(model: [])
            section.cellModel.append(contentsOf: coinsCellViewModel)
            self.dataSource.accept([section])
            self.page += 1
            self.isProcessing.accept(false)
        } onFailure: { [weak self] error in
            guard let self = self else {
                self?.error.accept(CommonError.missingSelf)
                self?.isProcessing.accept(false)
                return
            }
            self.isProcessing.accept(false)
            self.error.accept(error)
        }.disposed(by: disposeBag)
    }
    
    
    func broadCastUpdates() {
        Observable<Int>.interval(.seconds(5), scheduler: MainScheduler.asyncInstance).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.input.coinService.fetchUpdates(route: CoinsParams(page: self.page, onlyUpdates: true)).subscribe { [weak self] result in
                guard let self = self else { return }
                
                var updateCoinsInfo = [String: CoinUpdateInfo]()
                result.coins.forEach { updateCoinsInfo[$0.identifier] = $0 }

                let section = self.dataSource.value.first ?? CoinsSection(model: [])
                
                let updatedModels = section.cellModel.map { viewModel in
                    var updatedModel = viewModel
                    
                    updatedModel.price = self.currencyFormatter.string(from: NSNumber(value: updateCoinsInfo[viewModel.id]?.priceUSD ?? 0.0)) ?? "0.0"
                    
                   return updatedModel
                }
                
                section.cellModel = updatedModels
                self.dataSource.accept([section])
                
            }.disposed(by: self.disposeBag)
        }).disposed(by: timerDisposeBag)
    }
    
    func stopBroadCastTimer() {
        timerDisposeBag = DisposeBag()
    }
    
    private func createCell(coin: Coin) -> CoinsListCellViewModel {
        let price = self.currencyFormatter.string(from: NSNumber(value: coin.priceUSD ?? 0.0)) ?? "0.0"
        
        var percentChangeForDay: String?
        if let percentChangeDay = coin.percentChangeForDay {
            percentChangeForDay = String(format: "%.02f", fabs(percentChangeDay )) + "%"
        }
        
        var percentViewBGColor: UIColor = .clear
        if let percentChangeDay = coin.percentChangeForDay {
            percentViewBGColor = percentChangeDay > 0 ? .csRedWithAlpha : .csGreenWithAlpha
        }
        
        var percentTextColor: UIColor = .clear
        if let percentChangeDay = coin.percentChangeForDay {
            percentTextColor = percentChangeDay > 0 ? .csGreen : .csRed
        }
        
        var percentImage: UIImage?
        if let percentChangeForDay = coin.percentChangeForDay {
            if percentChangeForDay > 0 {
                percentImage = #imageLiteral(resourceName: "ic_triangle_top").withTintColor(.csGreen)
            } else if percentChangeForDay < 0 {
                percentImage = #imageLiteral(resourceName: "ic_triangle_bottom").withTintColor(.csRed)
            } else {
                percentImage = nil
            }
            
        }
        
        return CoinsListCellViewModel(downloadManager: self.input.downloadService,
                                      name: coin.name,
                                      symbol: coin.symbol,
                                      rank: String(coin.rank),
                                      price: price,
                                      id: coin.identifier,
                                      percentChangeForDay: percentChangeForDay,
                                      isHiddenPercentView: coin.percentChangeForDay == nil,
                                      percentViewBGColor: percentViewBGColor,
                                      percentTextColor: percentTextColor,
                                      imageURL: coin.iconUrl,
                                      percentImage: percentImage)
    }
}
