//
//  DataSource.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit
import RxSwift
import RxRelay

protocol DataSource: ViewModeling {
    associatedtype Section: DataSectionable

    var dataSource: BehaviorRelay<[Section]> { get set }
}

extension DataSource {
    func cellModel(for indexPath: IndexPath) -> Section.CellModel? {
        return dataSource.value[safe: indexPath.section]?.cellModel[safe: indexPath.row]
    }

    func headerModel(for section: Int) -> Section.HeaderModel? {
        return dataSource.value[safe: section]?.headerModel
    }

    func footerModel(for section: Int) -> Section.FooterModel? {
        return dataSource.value[safe: section]?.footerModel
    }
}
