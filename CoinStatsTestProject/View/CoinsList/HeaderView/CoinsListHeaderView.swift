//
//  CoinsListHeaderView.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

final class CoinsListHeaderView: SetupableTableViewHeaderFooter {
    
    typealias Model = CoinsListHeaderViewModel
    
    @IBOutlet private weak var coinLabel: UILabel!
    @IBOutlet private weak var hoursLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    private var model: CoinsListHeaderViewModel!
    
    static var nibName: String? {
        return "CoinsListHeaderView"
    }
    
    static var identity: String? {
        return "CoinsListHeaderView"
    }
    
    func setup(with model: CoinsListHeaderViewModel) {
        self.model = model
        coinLabel.text = model.coin
        hoursLabel.text = model.hours
        priceLabel.text = model.price
    }
}
