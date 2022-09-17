//
//  CoinDetailViewModel.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 17.09.22.
//

import UIKit
import RxRelay

final class CoinDetailViewModel: BaseViewModel<CoinDetailInput> {
    private var coinID: String?
    var title: String = Constants.NavigationTitles.coinsDetailsViewControllerTitle
    var name: String {
        if let coinID = coinID {
            return "More detailed info about \(coinID) will be soon"
        }
        return "Coming soon"
    }

    func setup(coinID: String) {
        self.coinID = coinID
    }

    func fetchCoinDetails() {
        guard let coinID = coinID else {
            error.accept(CommonError.missingSelf)
            return
        }
        self.isProcessing.accept(true)
        input.coinService.fetch(route: CoinDetailParams(id: coinID)).subscribe { [weak self] coin in
            guard let self = self else {
                self?.error.accept(CommonError.missingSelf)
                self?.isProcessing.accept(false)
                return
            }
            print(coin)
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
}
