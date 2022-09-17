//
//  DataSectionable.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

protocol DataSectionable {
    associatedtype HeaderModel
    associatedtype CellModel
    associatedtype FooterModel: Emptiable

    var headerModel: HeaderModel { get }
    var cellModel: [CellModel] { get }
    var footerModel: FooterModel { get }
}
