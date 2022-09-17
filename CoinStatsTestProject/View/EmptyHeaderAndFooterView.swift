//
//  EmptyHeaderAndFooterView.swift
//  CoinStatsTestProject
//
//  Created by Albert Mnatsakanyan on 16.09.22.
//

import UIKit

final class EmptyHeaderAndFooterView: SetupableTableViewHeaderFooter {
    static var nibName: String?
    static var identity: String?
    
    typealias Model = EmptyModel
    
    func setup(with model: EmptyModel) { }
}
