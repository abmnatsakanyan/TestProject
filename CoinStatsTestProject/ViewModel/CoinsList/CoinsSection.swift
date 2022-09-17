//
//  CoinsSection.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import Foundation

final class CoinsSection: DataSectionable {

    typealias HeaderModel = CoinsListHeaderViewModel
    typealias CellModel = CoinsListCellViewModel
    typealias FooterModel = EmptyModel

    var headerModel: CoinsListHeaderViewModel = CoinsListHeaderViewModel()
    var cellModel: [CoinsListCellViewModel]
    var footerModel: EmptyModel

    init(model: [CoinsListCellViewModel], headerModel: CoinsListHeaderViewModel = CoinsListHeaderViewModel(), footerModel: EmptyModel = EmptyModel()) {
        self.cellModel = model
        self.headerModel = headerModel
        self.footerModel = footerModel
    }
}
