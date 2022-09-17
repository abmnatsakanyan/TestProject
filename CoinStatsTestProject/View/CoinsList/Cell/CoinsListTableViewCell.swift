//
//  CoinsListTableViewCell.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import RxSwift

final class CoinsListTableViewCell: SetupableTableViewCell {
    
    typealias Model = CoinsListCellViewModel

    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var rankLabel: UILabel!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    @IBOutlet private weak var percentView: UIView!
    @IBOutlet private weak var percentImageView: UIImageView!
    @IBOutlet private weak var percentLabel: UILabel!
    
    
    private var model: CoinsListCellViewModel!
    private var disposeBag: DisposeBag = DisposeBag()

    override func prepareForReuse() {
        model.cancelDownloading()
        coinImageView.image = nil
        super.prepareForReuse()
    }
    
    static var nibName: String? {
        return "CoinsListTableViewCell"
    }
    
    static var identity: String? {
        return "CoinsListTableViewCell"
    }
    
    func setup(with model: CoinsListCellViewModel) {
        self.model = model
        nameLabel.text = model.name
        rankLabel.text = model.rank
        symbolLabel.text = model.symbol
        percentView.isHidden = model.isHiddenPercentView
        percentView.backgroundColor = model.percentViewBGColor
        percentImageView.image = model.percentImage
        percentLabel.text = model.percentChangeForDay
        percentLabel.textColor = model.percentTextColor
        priceLabel.text = model.price
        
        model.downloadImage().bind(to: coinImageView.rx.image).disposed(by: disposeBag)
    }
}
